# Building VM Templates in Proxmox

## Debian 12

```bash
# Pull down the raw image (need for ZFS, change .raw to .qcow2 if not ZFS)
    wget https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-generic-amd64.raw

# Create the VM and give it a name
    qm create 9000 --name debian12-k3s-agent --net0 virtio,bridge=vmbr0 --scsihw virtio-scsi-pci --machine q35

# Set the Vm Disk
    qm set 9000 --virtio0 local-zfs:0,discard=on,format=raw,import-from=/root/debian-12-generic-amd64.raw

# Resize the disk
    qm disk resize 9000 virtio0 8G

# Set the boot order
    qm set 9000 --boot order=virtio0

# Set CPU and Memory
    qm set 9000 --cpu host --cores 2 --memory 2048

# configure BIOS and EFI
    qm set 9000 --bios ovmf --efidisk0 local-zfs:1,format=raw,efitype=4m,pre-enrolled-keys=1

# Setting up Cloud-Init
    qm set 9000 --ide2 local-zfs:cloudinit

# Enable QEMU Guest Agent
    qm set 9000 --agent enabled=1

# Open up the Cloud Init Settings in Proxmox
# Set the username an password for the user
# Set DHCP to true
# Set SSH keys
# Regenerate Image

# Turn the VM Into a tempalte 
qm template 9000

# Add the CIFS Disk on cluster-zfs 250G
# Clone the VM
# Give it a Hostname
# Go into Cloud-Init and set its fixed IP
# Boot the Machine
# ssh into it

# Update and install QEMU Guest Agent
sudo apt update
sudo apt install -y qemu-guest-agent
sudo reboot
```
