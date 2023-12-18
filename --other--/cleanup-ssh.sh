#!/bin/bash

# Remove old host keys from the known_hosts file
for i in {101..103} {111..116}; do
  ssh-keygen -f "/home/gavin/.ssh/known_hosts" -R "10.90.3.$i"
done

# Specify the username for the SSH connection
username="k3sadmin"

# Loop through the IP ranges
for i in {101..103} {111..116}; do
  ip="10.90.3.$i"
  
  # Use SSH to connect to the IP and automatically add the new host key to the known_hosts file
  ssh -o StrictHostKeyChecking=accept-new $username@$ip exit
done