#!/bin/bash

set -e
set -x

# https://wiki.artixlinux.org/Main/Installation#Partition_your_disk_.28BIOS.29
echo '
  label: dos
  - - L *
' | sfdisk --quiet /dev/sda
mkfs.ext4 -q /dev/sda1
mount /dev/sda1 /mnt

# https://wiki.artixlinux.org/Main/Installation#Install_base_system
basestrap /mnt base openrc > /dev/null
fstabgen -U /mnt >> /mnt/etc/fstab
