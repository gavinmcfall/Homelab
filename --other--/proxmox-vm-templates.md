# Building VM Templates in Proxmox

## Debian 12

```bash
# Attaching Physical Disks

    # Finding the disk IDs
        find /dev/disk/by-id/ -type l|xargs -I{} ls -l {}|grep -v -E '[0-9]$' |sort -k11|cut -d' ' -f9,10,11,12

    # Attaching the disk to the VM
        qm set vmID type DiskID
        qm set 111 -scsi0 /dev/disk/by-id/scsi-35002538f4372f436

```
