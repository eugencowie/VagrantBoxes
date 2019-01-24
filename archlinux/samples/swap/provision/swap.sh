#!/bin/bash -ex

# https://wiki.archlinux.org/index.php/Swap#Swap_file_creation
fallocate --length 512M /swapfile
chmod 600 /swapfile
mkswap /swapfile > /dev/null
swapon /swapfile
echo '/swapfile none swap defaults 0 0' >> /etc/fstab
