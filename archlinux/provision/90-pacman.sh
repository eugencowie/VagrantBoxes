#!/bin/bash

[[ $quiet == true ]] && devnull=/dev/null || devnull=/dev/stdout
set -e
set -x

# https://wiki.archlinux.org/index.php/Mirrors#Enabling_a_specific_mirror
echo 'Server = http://mirrors.kernel.org/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist

# https://wiki.archlinux.org/index.php/Mirrors#Force_pacman_to_refresh_the_package_lists
pacman --sync --refresh --refresh --sysupgrade --sysupgrade --noconfirm >$devnull

# https://wiki.archlinux.org/index.php/Pacman#Cleaning_the_package_cache
yes | pacman --sync --clean --clean >$devnull
