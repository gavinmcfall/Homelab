#!/bin/sh
cd "$(dirname "$0")/../k3s_cluster/worker"
export TF_LOG=DEBUG
terraform apply -auto-approve plan.out