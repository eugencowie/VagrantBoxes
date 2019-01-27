#!/bin/bash -ex

# https://wiki.voidlinux.org/Installation_via_chroot#Partitioning_and_formatting
cat << 'END' | sfdisk --quiet /dev/sda
  label: dos
  - - L *
END
mkfs.ext4 -q /dev/sda1
mount /dev/sda1 /mnt

# https://wiki.voidlinux.org/Installation_on_UEFI,_via_chroot#Installing_Void
[[ $arch == x86_64-musl ]] && libc=/musl
yes | XBPS_ARCH="$arch" xbps-install --yes --sync -R "${mirror:-http://alpha.us.repo.voidlinux.org}/current$libc" --rootdir /mnt base-system > /dev/null

# https://wiki.voidlinux.org/Installation_via_chroot#Editing_fstab
echo "UUID=$(blkid --match-tag UUID --output value /dev/sda1) / ext4 defaults 0 1" >> /mnt/etc/fstab

# https://wiki.voidlinux.org/Installation_via_chroot#Mounting_system_directories
mount --types proc /proc /mnt/proc
mount --rbind --make-rslave /sys /mnt/sys
mount --rbind --make-rslave /dev /mnt/dev

# https://wiki.voidlinux.org/Installation_on_UEFI,_via_chroot#Installing_Void
cp --dereference /etc/resolv.conf /mnt/etc/resolv.conf
