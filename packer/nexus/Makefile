default:

# proxmox-ubuntu-20-04:
# 	sh ./scripts/ubuntu-20.04.sh
#	sh ./scripts/cleanup.sh ./packer/ubuntu-20.04

proxmox-ubuntu-22-04:
	sh ./scripts/ubuntu-22.04.sh
	sh ./scripts/cleanup.sh

master-k3s:
	sh ./scripts/master-k3s.sh
	sh ./scripts/cleanup.sh

agent-k3s:
	sh ./scripts/agent-k3s.sh
	sh ./scripts/cleanup.sh

clean:
	sh ./scripts/cleanup.sh