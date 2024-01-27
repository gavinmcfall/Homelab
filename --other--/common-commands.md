# Common Commands

```bash
    # Kubectl Cheat Cheat
    https://kubernetes.io/docs/reference/kubectl/quick-reference/
```

## AWS CLI - Remove contents of a bucket
```bash
    aws s3 rm s3://<bucket-name> --endpoint-url https://<cloudflare-id>.r2.cloudflarestorage.com --recursive --dryrun
```

## Flux reconcile

```bash
    flux reconcile source git home-kubernetes -n flux-system
```

## rClone Manual Sync

```bash
    rclone sync --max-age=30h /mnt/proxmox-backups/ backblaze:harbourside-proxmox-backups/ -P
```

## Kube ctl commands

```bash
    # Fixing Kube config after a fresh install
        scp k3sadmin@10.90.3.101:/etc/rancher/k3s/k3s.yaml ~/k3s.yaml
        export KUBECONFIG=~/.kube/config:~/k3s.yaml
        sed -i 's/server: https:\/\/127.0.0.1:6443/server: https:\/\/10.90.3.100:6443/g' ~/.kube/config

    # Draining/Cordoning and Uncordoning
        # Drain and Cordone
            kubectl drain node/{nodeName} --ignore-daemonsets --delete-emptydir-data --force
        # Uncordone
            kubectl uncordon node/{nodeName}



```

## Mounting cifs shares

```bash
    #  Mounting the shares temporarily
        sudo mount -t cifs //10.90.100.1/kubeShare /mnt/kubeShare -o username="username",password="password",vers=2.0
        sudo mount -t cifs //10.90.100.1/devShare /mnt/devShare -o username="username",password="password",vers=2.0
        sudo mount -t cifs //10.90.100.1/dockerShare /mnt/dockerShare -o username="username",password="password",vers=2.0
        sudo mount -t cifs //10.90.100.1/hostShare /mnt/hostShare -o username="username",password="password",vers=2.0

    #  Mounting the shares permanently
        //10.90.100.1/kubeShare /mnt/kubeShare cifs username="username",password="password",vers=2.0 0 0
        //10.90.100.1/devShare /mnt/devShare cifs username="username",password="password",vers=2.0 0 0
        //10.90.100.1/dockerShare /mnt/dockerShare cifs username="username",password="password",vers=2.0 0 0
        //10.90.100.1/hostShare /mnt/hostShare cifs username="username",password="password",vers=2.0 0 0
```

## Packer

```bash
    # Installing Proxmox Plugin
        packer plugins install github.com/hashicorp/proxmox

    # Initilize and upgrade plugins
        packer init -upgrade
    
    #  Building a packer VM Template (need to be in the correct dir: /Homelab/packer/nexus/9001-ubuntu-server-jammy-k3s)
        packer build -var-file='./variables.pkr.hcl' ./ubuntu-server-jammy-k3s.pkr.hcl
```

## Terraform

```bash
    #  Terraform init
        terraform init # this will download the plugins needed for the terraform plan

    #  Terraform validate
        terraform validate # this will validate your terraform plan
    
    #  Testing your terraform plan ans saving the plan to a file
        terraform plan -out=plan.out
    
    #  Running your terraform plan
        terraform apply "plan.out"
        terraform apply -auto-approve "plan.out" # wont ask permission to do anything, runs unattended
    
    #  Destroy the VMs you built
        terraform destroy
        terraform destroy -auto-approve # wont ask permission to do anything, runs unattended
```

## VS Code - Emphasised Items

```bash
    Ctrl + Shift + P
    Developer: Reload Window
```

## Ansible

```bash
    # Syntax notes
        # Validate playbook before running (note some tasks ignore check)
            --check
    
    # K3S - Run from /ansible/main
        # Preparing nodes
            ansible-playbook -i ./Inventory ./playbooks/cluster-prepare.yaml --vault-password-file ../secrets/passwd_files/harbourside.pass
    
    # MANAGEMENT - Run from ~/Homelab/ansible/management
        # Power State
            # Start
                ansible-playbook -i ./Inventory ./playbooks/power-startup-k3s.yaml --vault-password-file ../secrets/passwd_files/harbourside.pass
            # Reboot
                ansible-playbook -i ./Inventory ./playbooks/power-reboot-k3s.yaml --vault-password-file ./secrets/passwd_files/harbourside.pass
            # Shutdown
                ansible-playbook -i ./Inventory ./playbooks/power-shutdown-k3s.yaml
        # Update Ubuntu
            ansible-playbook -i ./Inventory ./playbooks/update-apt-packages.yaml --vault-password-file ./secrets/passwd_files/harbourside.pass    

    # Editing a Vault - Run from ~/Homelab/ansible
        ansible-vault edit --vault-password-file ./secrets/passwd_files/harbourside.pass ./secrets/vaults/harbourside.yml 
```

## SOPS Encryption

```bash
    #  Encrypt
        sops -e --in-place <filename>

    # Decrypt
        sops -d --in-place <filename>
```

## Clearing Chrome SSL State

```bash
    # In Windows
    Internet Options > Content > Clear SSL State
    
    # In Chrome
    chrome://restart
```

## Setting Permissions on NFS Share

```bash
    # modifing for group write
    sudo chmod -R 777 /mnt/data/

    #setting kah perms
    sudo setfacl -Rm g:10000:rwx /mnt/data/
    sudo setfacl -Rm u:568:rwx,g:568:rwx /mnt/data/

```