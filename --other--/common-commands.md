# Common Commands

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
    # Ruuning a playbook from ~/projects/ansible
        ansible-playbook -i ./inventory ./playbooks/update-apt-packages.yaml --vault-password-file ./secrets/passwd_files/harbourside.pass
    
    # Checking everything works before running the playbook
        ansible-playbook -i ./inventory ./playbooks/update-apt-packages.yaml --vault-password-file ./secrets/passwd_files/harbourside.pass --check
    
    # Change VM State
        ansible-playbook -i ./inventory ./playbooks/power-reboot-k3s.yaml --vault-password-file ./secrets/passwd_files/harbourside.pass 
        
        ansible-playbook -i ./inventory ./playbooks/power-startup-k3s.yaml --vault-password-file ./secrets/passwd_files/harbourside.pass 
        
        ansible-playbook -i ./inventory ./playbooks/power-shutdown-k3s.yaml --vault-password-file ./secrets/passwd_files/harbourside.pass 

    # Editing a Vault
        ansible-vault edit --vault-password-file ./secrets/passwd_files/harbourside.pass ./secrets/vaults/harbourside.yml 
```

## SOPS Encryption

```bash
    #  Encrypt
        sops -e --in-place <filename>

    # Decrypt
        sops -d --in-place <filename>
```
