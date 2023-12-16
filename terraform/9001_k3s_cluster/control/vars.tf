# OnePassword Vault: homelab

# data "onepassword_item" "proxmox_api_url" {
#   vault = "homelab"
#   title = "ProxMox/add more/nexus-api"
# }

# data "onepassword_item" "proxmox_api_token_id" {
#   vault = "homelab"
#   title = "Proxmox-Users/Terraform/Terraform-Token-ID"
# }

# data "onepassword_item" "proxmox_api_token_secret" {
#   vault = "homelab"
#   title = "Proxmox-Users/Terraform/Terraform-Secret"
# }

# data "onepassword_item" "ssh_key_01" {
#   vault = "homelab"
#   title = "sshkeys/uwtt3vddfmulvrhwwzaskiwck4/wsl2-ssh-key"
# }

# data "onepassword_item" "ssh_key_02" {
#   vault = "homelab"
#   title = "sshkeys/iwsa2h2wx4qeyy2yayltvy5pby/nerdzpc-ssh-key"
# }

# data "onepassword_item" "admin_username" {
#   vault = "homelab"
#   title = "k3s_admin/username"
# }

# data "onepassword_item" "admin_password" {
#   vault = "homelab"
#   title = "k3s_admin/password"
# }

# Defined Variables

variable "template_name" {
    default = "ubuntu-server-jammy-k3s"
}

variable "proxmox_host" {
    default = "nexus"
}

# variable "onepassword_token" {
#   description = "The token for 1Password"
#   type        = string
#   sensitive   = true
# }

# variable "onepassword_url" {
#   description = "The url for 1Password"
#   type        = string
#   sensitive   = true
# }

# variable "onepassword_account" {
#   description = "The account ID for 1Password"
#   type        = string
#   sensitive   = true
# }

# variable "service_account_token" {
#   description = "The account ID for 1Password"
#   type        = string
#   sensitive   = true
# }
