#!/bin/bash

set -e
set -x

# https://wiki.archlinux.org/index.php/Swap#Swap_file_creation
fallocate -l 512M /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo '/swapfile none swap defaults 0 0' >> /etc/fstab
