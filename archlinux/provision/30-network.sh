#!/bin/bash

[[ $quiet == true ]] && quiet="--quiet"
set -e
set -x

# https://wiki.archlinux.org/index.php/Network_configuration#Revert_to_traditional_interface_names
ln --symbolic --force /dev/null /etc/udev/rules.d/80-net-setup-link.rules

# https://wiki.archlinux.org/index.php/Dhcpcd#Running
systemctl $quiet enable dhcpcd@eth0
