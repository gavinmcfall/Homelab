# My ProxMox IP Address
proxmox_api_url = "{{ op://homelab/ProxMox/api-url/url }}"

# Packer API Credentials for ProxMox
proxmox_api_token_id = "{{ op://homelab/Proxmox-Users/Packer/Packer-Token-ID }}"
proxmox_api_token_secret = "{{ op://homelab/Proxmox-Users/Packer/Packer-Secret }}"

# Template Name
template_name = "agent-k3s"

# ProxMox node
proxmox_node = "nexus"