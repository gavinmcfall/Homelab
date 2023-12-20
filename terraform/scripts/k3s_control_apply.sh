#!/bin/sh
cd "$(dirname "$0")/../k3s_cluster/control"
export TF_LOG=DEBUG
terraform apply -auto-approve "plan.out"