# Control Plane Node

```bash
    1x Master (tainted)
    • 6 Cores
    • 16 GB RAM
    • 120 GB virtio0 vdisk (local-zfs) = OS Disk
```

# Worker Agents

```bash
    3x Workers
    • 12 Cores
    • 24+ GB RAM
    • 120 GB virtio0 vdisk (local-zfs) = OS Disk
    • 2TB SSD Passthru = Ready for Longhorn or Rook Ceph
```

# Physical Disks for Rook Ceph

```bash
Pyro-01
    qm set 111 -scsi0 /dev/disk/by-id/scsi-35002538f4372f436

Pyro-02
    qm set 112 -scsi0 /dev/disk/by-id/scsi-35002538f4372f42c

Pyro-03
    qm set 113 -scsi0 /dev/disk/by-id/scsi-35002538f4260f8a7
```
