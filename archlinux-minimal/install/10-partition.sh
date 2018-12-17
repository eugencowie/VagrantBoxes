#!/bin/bash

set -e
set -x

# https://unix.stackexchange.com/questions/145332/difference-between-sdx-and-vdx/145336#145336
if   [ -e /dev/vda ]; then device=/dev/vda
elif [ -e /dev/sda ]; then device=/dev/sda
else exit 1; fi

# https://wiki.archlinux.org/index.php/Installation_guide#Partition_the_disks
parted --script "$device" mklabel msdos
parted --script "$device" mkpart primary ext4 0% 100%
parted --script "$device" set 1 boot on
