#!/bin/bash

set -e
set -x

# https://wiki.archlinux.org/index.php/Mirrors
echo 'Server = http://mirrors.kernel.org/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist
pacman -Syyu --noconfirm

# https://wiki.archlinux.org/index.php/Pacman#Cleaning_the_package_cache
yes | pacman -Scc
