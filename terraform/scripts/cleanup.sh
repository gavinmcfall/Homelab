#!/bin/sh
cd "$(dirname "$0")/../9001_k3s_cluster/control"
rm -rf vars.tf
cd "$(dirname "$0")/../9001_k3s_cluster/worker"
rm -rf vars.tf