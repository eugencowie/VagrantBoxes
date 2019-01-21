#!/bin/bash

set -e
set -x

# https://wiki.archlinux.org/index.php/Mirrors#Enabling_a_specific_mirror
echo 'Server = http://archlinux.mirrors.uk2.net/$repo/os/$arch' > /etc/pacman.d/mirrorlist

# https://wiki.archlinux.org/index.php/Mirrors#Force_pacman_to_refresh_the_package_lists
pacman -Syyuu --noconfirm

# https://www.archlinux.org/pacman/pacman.conf.5.html#_options
sed -i '/#TotalDownload/s/^#//' /etc/pacman.conf
