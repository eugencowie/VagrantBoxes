#!/bin/bash

set -e
set -x

mirror="${mirror:-http://mirrors.kernel.org/archlinux}"

# https://unix.stackexchange.com/questions/145332/difference-between-sdx-and-vdx/145336#145336
if   [ -e /dev/vda ]; then device=/dev/vda
elif [ -e /dev/sda ]; then device=/dev/sda
else exit 1; fi

# https://wiki.archlinux.org/index.php/Installation_guide#Partition_the_disks
parted --script "$device" mklabel msdos
parted --script "$device" mkpart primary ext2 1MiB 201MiB
parted --script "$device" mkpart primary ext4 201MiB 100%
parted --script "$device" set 1 boot on

# https://wiki.archlinux.org/index.php/Installation_guide#Format_the_partitions
mkfs.ext2 -q "${device}1"
mkfs.ext4 -q "${device}2"

# https://wiki.archlinux.org/index.php/Installation_guide#Mount_the_file_systems
mount "${device}2" /mnt && mkdir /mnt/boot
mount "${device}1" /mnt/boot

# https://wiki.archlinux.org/index.php/Installation_guide#Select_the_mirrors
echo "Server = ${mirror}/\$repo/os/\$arch" > /etc/pacman.d/mirrorlist

# https://wiki.archlinux.org/index.php/Installation_guide#Install_the_base_packages
pacstrap /mnt base grub sudo openssh

# https://wiki.archlinux.org/index.php/Installation_guide#Fstab
genfstab -U /mnt >> /mnt/etc/fstab
