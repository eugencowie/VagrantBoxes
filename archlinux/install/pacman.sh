#!/bin/bash -ex

# https://wiki.archlinux.org/index.php/Mirrors#Enabling_a_specific_mirror
echo 'Server = http://mirrors.kernel.org/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist
pacman --noconfirm --sync --refresh --refresh --sysupgrade --sysupgrade > /dev/null

# https://wiki.archlinux.org/index.php/Pacman#Cleaning_the_package_cache
yes | pacman --sync --clean --clean > /dev/null
