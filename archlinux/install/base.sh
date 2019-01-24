#!/bin/bash -ex

# https://wiki.archlinux.org/index.php/Installation_guide#Partition_the_disks
parted --script /dev/sda mklabel msdos
parted --script /dev/sda mkpart primary ext4 0% 100%
parted --script /dev/sda set 1 boot on

# https://wiki.archlinux.org/index.php/Installation_guide#Format_the_partitions
mkfs.ext4 -q /dev/sda1

# https://wiki.archlinux.org/index.php/Installation_guide#Mount_the_file_systems
mount /dev/sda1 /mnt

# https://wiki.archlinux.org/index.php/Installation_guide#Select_the_mirrors
echo 'Server = '"${mirror:-http://mirrors.kernel.org/archlinux}"'/$repo/os/$arch' > /etc/pacman.d/mirrorlist

# https://wiki.archlinux.org/index.php/Installation_guide#Install_the_base_packages
pacstrap /mnt base > /dev/null

# https://wiki.archlinux.org/index.php/Installation_guide#Fstab
genfstab -U /mnt >> /mnt/etc/fstab
