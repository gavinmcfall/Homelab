variable "template_name" {
    default = "agent-k3s"
}

variable "proxmox_host" {
    default = "nexus"
}

variable "pm_api_url" {
    default = "{{ op://homelab/ProxMox/api-url/url }}"
}

variable "pm_api_token_id" {
    default = "{{ op://homelab/Proxmox-Users/Terraform/Terraform-Token-ID }}"
}

variable "pm_api_token_secret" {
    default = "{{ op://homelab/Proxmox-Users/Terraform/Terraform-Secret }}"
}

variable "admin_user" {
    default = "{{ op://homelab/k3s_admin/username }}"
}

variable "admin_password" {
    default = "{{ op://homelab/k3s_admin/password}}"
}

variable "ssh_key_01" {
    default = "{{ op://homelab/sshkeys/uwtt3vddfmulvrhwwzaskiwck4/wsl2-ssh-key }}"
}

variable "ssh_key_02" {
    default = "{{ op://homelab/sshkeys/iwsa2h2wx4qeyy2yayltvy5pby/nerdzpc-ssh-key}}"
}