# Handling “Too Many PGs per OSD” in Rook Ceph

This guide records the playbook we followed on 2025-11-01 when Ceph started warning that each OSD hosted too many placement groups (PGs). It assumes you have `kubectl` access to the `rook-ceph` namespace and that the toolbox pod (`deploy/rook-ceph-tools`) is available.

---

## 1. Spot the Warning

```bash
KUBECONFIG=~/home-ops/kubeconfig \
kubectl -n rook-ceph exec deploy/rook-ceph-tools -- ceph status
```

Look for `HEALTH_WARN too many PGs per OSD (XXX > max 250)`. Capture the total PG count and verify that all OSDs are up so you know the warning is PG-related rather than an OSD outage.

If you want the detailed message without the status summary:

```bash
KUBECONFIG=~/home-ops/kubeconfig \
kubectl -n rook-ceph exec deploy/rook-ceph-tools -- ceph health detail
```

---

## 2. Quantify PG Usage Per Pool

Run `ceph df detail` to see which pools exist and how many PGs they consume:

```bash
KUBECONFIG=~/home-ops/kubeconfig \
kubectl -n rook-ceph exec deploy/rook-ceph-tools -- ceph df detail
```

Sort the output by pool name. In our incident we found three legacy pools: `default.rgw.log`, `default.rgw.control`, and `default.rgw.meta`. They belonged to an unused RGW realm, yet each still reserved 8 PGs, pushing us over the per-OSD threshold.

---

## 3. Confirm Whether Pools Are Safe to Remove

1. List realms, zonegroups, and zones:
   ```bash
   kubectl -n rook-ceph exec deploy/rook-ceph-tools -- radosgw-admin realm list
   kubectl -n rook-ceph exec deploy/rook-ceph-tools -- radosgw-admin zonegroup list
   kubectl -n rook-ceph exec deploy/rook-ceph-tools -- radosgw-admin zone list
   ```
2. If you find an old realm (ours was named `default`) with zero buckets or clients, mark it for deletion. Double-check that the active realm (e.g., `home`) is still healthy before proceeding.

---

## 4. Clean Up the Legacy RGW Stack

> **Note:** These deletions are irreversible. Only run them after confirming no workloads depend on the target realm.

1. Delete the unused zone and zonegroup:
   ```bash
   kubectl -n rook-ceph exec deploy/rook-ceph-tools -- \
     radosgw-admin zone delete --rgw-zone=<zone> --rgw-zonegroup=<zonegroup> --rgw-realm=<realm>

   kubectl -n rook-ceph exec deploy/rook-ceph-tools -- \
     radosgw-admin zonegroup delete --rgw-zonegroup=<zonegroup> --rgw-realm=<realm>
   ```
2. Update the RGW period so the cluster accepts the change:
   ```bash
   kubectl -n rook-ceph exec deploy/rook-ceph-tools -- \
     radosgw-admin period update --rgw-realm=<active-realm> --commit
   ```
3. Remove the empty pools that belonged to the retired realm. Use both confirm flags to bypass the interactive prompt:
   ```bash
   kubectl -n rook-ceph exec deploy/rook-ceph-tools -- \
     ceph osd pool rm default.rgw.log default.rgw.log --yes-i-really-really-mean-it

   kubectl -n rook-ceph exec deploy/rook-ceph-tools -- \
     ceph osd pool rm default.rgw.control default.rgw.control --yes-i-really-really-mean-it

   kubectl -n rook-ceph exec deploy/rook-ceph-tools -- \
     ceph osd pool rm default.rgw.meta default.rgw.meta --yes-i-really-really-mean-it
   ```

---

## 5. Verify the Fix

1. Re-run `ceph status` and confirm the health returns to `HEALTH_OK`.
2. Check `ceph df detail` again; PG count should drop (ours fell from 265 to 169 total, ~169 per OSD).
3. Watch the Prometheus Ceph alerts (or Grafana dashboards) to ensure the warning stays cleared for at least one full scrape interval.

---

## 6. Prevent Recurrence

- When decommissioning RGW realms/zonegroups, delete their pools immediately so they do not keep PGs allocated.
- Keep total PGs per OSD <250 by using the Ceph PG calculator when adding pools or resizing them.
- Automate a periodic check (`ceph status` + `ceph df detail`) and alert if PG count rises unexpectedly, so we catch rogue pools sooner.
