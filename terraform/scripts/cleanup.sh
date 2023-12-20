#!/bin/sh
original_dir=$(pwd)
cd "$(dirname "$0")/../k3s_cluster/control"
rm -rf vars.tf
cd "$original_dir"
cd "$(dirname "$0")/../k3s_cluster/worker"
rm -rf vars.tf