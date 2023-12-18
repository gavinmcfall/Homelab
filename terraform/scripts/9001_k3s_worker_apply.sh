#!/bin/sh
cd "$(dirname "$0")/../9001_k3s_cluster/worker"
export TF_LOG=DEBUG
terraform apply -auto-approve -parallelism=1 plan.out