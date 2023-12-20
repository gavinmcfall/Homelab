terraform {
  required_providers {
    proxmox = { 
      source = "loeken/proxmox"
      version = ">=2.9.16"
    }
  }
}

provider "proxmox" {
 
  pm_api_url = var.pm_api_url
  
  pm_api_token_id = var.pm_api_token_id
  
  pm_api_token_secret = var.pm_api_token_secret
  
  pm_tls_insecure = true
}

# ProxMox Full-Clone
# This is a full clone of the template
# This is the control plane node
# This is the first node to be created


# resource is formatted to be "[type]" "[entity_name]"
resource "proxmox_vm_qemu" "worker_nodes" {

  #VM Building guide - How many, their ID and names.
  count = 6 # just want 1 for now
  vmid = tostring(110 + count.index + 1) # this will be the VM ID in proxmox. 101, 102, 103, etc.
  name = format("pyro-0%d", count.index + 1) #count.index starts at 0, so + 1 means this VM will be named pyro-01 in proxmox
  
# Other Configuration
  desc = <<EOF
# Operating System

> Ubuntu Server 22.04 LTS

# Primary Purpose

> K3s Worker Node
EOF
  onboot = true # start the VM when the host boots


  # Specify which ProxMox host to create the VM on
  target_node = var.proxmox_host
  
  # Tells Terraform which template to use
  clone = var.template_name
  full_clone = true # this is a full clone, not a linked clone
  
  # Basic VM settings here. agent refers to qemu-guest-agent
  agent = 1 # 1 = true, 0 = false (default)
  scsihw = "virtio-scsi-pci"
  os_type = "cloud-init"
  cores = 2
  sockets = 1
  cpu = "host"
  memory = 2048

  # Tagging the VMs
  tags = "k3s"

  # VM Disk Settings - Not Needed as template has this disk already

  # VM IP Settings
  ipconfig0 = format("ip=10.90.3.%d/16,gw=10.90.254.1", 110 + count.index + 1)
  nameserver = "10.90.1.10"
  
  # VM Network Settings
  network {
    model = "virtio"
    bridge = "vmbr0"
  }

  # VM Cloudinit Settings
  cloudinit_cdrom_storage = "local-zfs" # name of your proxmox storage
  ciuser = var.admin_user
  cipassword = var.admin_password
  sshkeys = <<EOF
  ${var.ssh_key_01}
  ${var.ssh_key_02}
  EOF

  #VM Lifecycle Settings - ignore_changes is used to prevent Terraform from trying to change these settings.
  lifecycle {
    ignore_changes = [
      disk,
      network,
    ]
  }
  
  # the ${count.index + 1} appends text to the end of something.
  # E.g for IP addresses, p=10.90.3.10${count.index + 1}/16 would be
  # 10.90.3.101/16 and the next VM would be: 10.90.3.102/16
}