#!/bin/sh
eval $(op signin)
cd "$(dirname "$0")/../9001_k3s_cluster/control"
op inject -i auto.tfvars -o vars.tf
terraform destroy -auto-approve
for i in $(seq 101 103)
do
  ssh-keygen -f "/home/gavin/.ssh/known_hosts" -R "10.90.3.$i"
done