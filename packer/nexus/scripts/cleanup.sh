#!/bin/sh
cd "$(dirname "$0")/../9001-ubuntu-server-jammy-k3s"
rm -rf *.auto.pkrvars.hcl

cd ../9002-master-k3s
rm -rf *.auto.pkrvars.hcl