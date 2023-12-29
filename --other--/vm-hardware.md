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
