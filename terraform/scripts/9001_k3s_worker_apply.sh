#!/bin/sh
cd "$(dirname "$0")/../9001_k3s_cluster/worker"
terraform apply -auto-approve "plan.out"