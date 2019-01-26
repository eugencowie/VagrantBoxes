#!/bin/bash -ex

# https://wiki.artixlinux.org/Main/Installation#Partition_your_disk_.28BIOS.29
cat << 'END' | sfdisk --quiet /dev/sda
  label: dos
  - - L *
END
mkfs.ext4 -q /dev/sda1
mount /dev/sda1 /mnt

# https://wiki.artixlinux.org/Main/Installation#Install_base_system
basestrap /mnt base "${init:-openrc}" > /dev/null 2> >(sed --unbuffered --regexp-extended '/^(==>| -->|  ->).*/d')
fstabgen -U /mnt >> /mnt/etc/fstab
