# My ProxMox IP Address
proxmox_api_url = "{{ op://homelab/ProxMox/add more/nexus-api }}"

# Packer API Credentials for ProxMox
proxmox_api_token_id = "{{ op://homelab/Proxmox-Users/Packer/Packer-Token-ID }}"
proxmox_api_token_secret = "{{ op://homelab/Proxmox-Users/Packer/Packer-Secret }}"

# Template Name
template_name = "ubuntu-server-jammy-k3s"

# ProxMox node
proxmox_node = "nexus"

# SSH Key
ssh_key_01 = "{{ op://homelab/sshkeys/uwtt3vddfmulvrhwwzaskiwck4/wsl2-ssh-key }}"