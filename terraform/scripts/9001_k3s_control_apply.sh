#!/bin/sh
cd "$(dirname "$0")/../9001_k3s_cluster/control"
export TF_LOG=DEBUG
terraform apply -auto-approve "plan.out"