#!/bin/sh
cd "$(dirname "$0")/../9001-ubuntu-server-jammy-k3s"
rm -rf *.auto.pkrvars.hcl

cd ../Ubuntu/9002-k3s-node
rm -rf *.auto.pkrvars.hcl