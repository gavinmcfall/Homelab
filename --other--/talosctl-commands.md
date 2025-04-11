# Network Interface & Address Metadata
This captures interface names, MACs, drivers, bus paths, MTUs, IPs, and routing data.

```bash
# 🔧 Replace with desired node IP: 10.90.3.101 / 102 / 103
NODE=10.90.3.101

{
  echo "== Interface Metadata =="
  talosctl -n $NODE get links -o json | jq -r '
    select(type == "object") |
    "Interface: \(.metadata.id)\n  MAC: \(.spec.hardwareAddr)\n  Driver: \(.spec.driver)\n  Bus Path: \(.spec.busPath // "null")\n  MTU: \(.spec.mtu)\n"'

  echo
  echo "== Assigned IP Addresses =="
  talosctl -n $NODE get addresses -o json | jq -r '
    select(type == "object") |
    "Interface: \(.spec.linkName)\n  Address: \(.spec.address)\n"'

  echo
  echo "== IPv4 Routes =="
  talosctl -n $NODE read /proc/net/route | grep -E 'thunderbolt|eth|bond' | awk '
    BEGIN {
      print "Interface      Destination IP (decoded)"
    }
    {
      hex=$2
      ip=sprintf("%d.%d.%d.%d", strtonum("0x" substr(hex,7,2)), strtonum("0x" substr(hex,5,2)), strtonum("0x" substr(hex,3,2)), strtonum("0x" substr(hex,1,2)))
      printf "%-14s %s\n", $1, ip
    }'
}
```

# Disk / SSD Metadata Verification

This verifies NVMe SSDs, models, serials, and symbolic links.

```bash
# 🔧 Replace with desired node IP: 10.90.3.101 / 102 / 103
NODE=10.90.3.101

# Get basic disk list
talosctl -n $NODE disks | grep -E 'nvme|by-id' --color=never

# Get model info for each disk device (adjust if you have more than nvme0/1)
talosctl -n $NODE read /sys/block/nvme0n1/device/model
talosctl -n $NODE read /sys/block/nvme1n1/device/model

# Get disk-by-id names
talosctl -n $NODE list /dev/disk/by-id
```