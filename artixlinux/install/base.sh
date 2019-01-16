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
(set -o pipefail; (basestrap /mnt base "${init:-openrc}" 3>&1 1>/dev/null 2>&3 \
  | sed --unbuffered --regexp-extended '/^(==>| -->|  ->).*/d') 1>&2)
fstabgen -U /mnt >> /mnt/etc/fstab
