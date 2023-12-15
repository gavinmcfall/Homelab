variable "onepassword_token" {
    default = ""
}

variable "proxmox_api_url" {
    default = "op://homelab/ProxMox/add more/nexus-api"
}

variable "proxmox_api_token_id" {
    default = "op://homelab/Proxmox-Users/Terraform/Terraform-Token-ID"
    sensitive = true
}

variable "proxmox_api_token_secret" {
    default = "op://homelab/Proxmox-Users/Terraform/Terraform-Secret"
    sensitive = true
}

variable "template_name" {
    default = "ubuntu-server-jammy-k3s"
}

variable "proxmox_host" {
    default = "nexus"
}

variable "ssh_key_01" {
    default = "op://homelab/sshkeys/uwtt3vddfmulvrhwwzaskiwck4/wsl2-ssh-key"
}

variable "ssh_key_02" {
    default = "op://homelab/sshkeys/iwsa2h2wx4qeyy2yayltvy5pby/nerdzpc-ssh-key"
    
}

variable "admin_password" {
  default = "op://homelab/k3s_admin/password"
}

variable "admin_username" {
  default = "op://homelab/k3s_admin/username"
}