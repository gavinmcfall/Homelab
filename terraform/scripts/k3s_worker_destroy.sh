#!/bin/sh
eval $(op signin)
cd "$(dirname "$0")/../k3s_cluster/worker"
op inject -i auto.tfvars -o vars.tf
terraform destroy -auto-approve
for i in $(seq 111 116)
do
  ssh-keygen -f "/home/gavin/.ssh/known_hosts" -R "10.90.3.$i"
done