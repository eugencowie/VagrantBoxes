#!/bin/bash

set -e
set -x

# https://linux.die.net/man/8/sfdisk
echo '
  label: dos
  - - L *
' | sfdisk --quiet /dev/sda

# https://wiki.voidlinux.org/Disks#Filesystems
mkfs.ext4 -q /dev/sda1

# https://wiki.voidlinux.org/Disks#Filesystems
mount /dev/sda1 /mnt

# https://wiki.voidlinux.org/Installation_on_UEFI,_via_chroot#Installing_Void
[[ $arch == x86_64-musl ]] && libc=/musl
yes | XBPS_ARCH="$arch" xbps-install --yes --sync -R "${mirror:-http://alpha.us.repo.voidlinux.org}/current$libc" --rootdir /mnt base-system > /dev/null

# https://wiki.voidlinux.org/Installation_via_chroot#Editing_fstab
echo "UUID=$(blkid --match-tag UUID --output value /dev/sda1) / ext4 defaults 0 1" >> /mnt/etc/fstab

# https://wiki.voidlinux.org/Installation_via_chroot#Mounting_system_directories
mount --rbind --make-rslave /dev  /mnt/dev
mount --rbind --make-rslave /proc /mnt/proc
mount --rbind --make-rslave /sys  /mnt/sys

# https://wiki.voidlinux.org/Installation_on_UEFI,_via_chroot#Installing_Void
cp /etc/resolv.conf /mnt/etc/resolv.conf
