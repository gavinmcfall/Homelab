#!/bin/sh
eval $(op signin)
cd "$(dirname "$0")/../9001_k3s_cluster/control"
op inject -i auto.tfvars -o vars.tf
terraform plan