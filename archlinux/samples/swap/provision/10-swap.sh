#!/bin/bash

[[ $quiet == true ]] && devnull=/dev/null || devnull=/dev/stdout
set -e
set -x

# https://wiki.archlinux.org/index.php/Swap#Swap_file_creation
fallocate --length 512M /swapfile
chmod 600 /swapfile
mkswap /swapfile >$devnull
swapon /swapfile
echo '/swapfile none swap defaults 0 0' >> /etc/fstab
