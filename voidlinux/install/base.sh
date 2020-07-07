#!/bin/bash -ex

# https://docs.voidlinux.org/installation/guides/chroot.html#prepare-filesystems
cat << 'END' | sfdisk --quiet /dev/sda
  label: dos
  - - L *
END
mkfs.ext4 -q /dev/sda1
mount /dev/sda1 /mnt

# https://docs.voidlinux.org/installation/guides/chroot.html#entering-the-chroot
mkdir --parents /mnt/{proc,sys,dev}
mount --rbind --make-rslave /proc /mnt/proc
mount --rbind --make-rslave /sys /mnt/sys
mount --rbind --make-rslave /dev /mnt/dev

# https://docs.voidlinux.org/installation/guides/chroot.html#base-installation
[[ $arch == x86_64-musl ]] && suffix=/musl
yes | XBPS_ARCH="$arch" xbps-install --yes --sync -R "${mirror:-https://alpha.de.repo.voidlinux.org}/current$suffix" --rootdir /mnt base-system > /dev/null

# https://docs.voidlinux.org/installation/guides/chroot.html#configure-fstab
echo "UUID=$(blkid --match-tag UUID --output value /dev/sda1) / ext4 defaults 0 1" >> /mnt/etc/fstab

# https://docs.voidlinux.org/installation/guides/chroot.html#entering-the-chroot
cp --dereference /etc/resolv.conf /mnt/etc/resolv.conf
