#!/bin/sh
eval $(op signin)
cd "$(dirname "$0")/../9001-ubuntu-server-jammy-k3s"
op inject -i variables.pkr.hcl -o variables.auto.pkrvars.hcl
packer build -var-file='./variables.auto.pkrvars.hcl' ./ubuntu-server-jammy-k3s.pkr.hcl