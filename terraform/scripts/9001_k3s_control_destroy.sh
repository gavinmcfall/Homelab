#!/bin/sh
eval $(op signin)
cd "$(dirname "$0")/../9001_k3s_cluster/control"
terraform destroy -auto-approve