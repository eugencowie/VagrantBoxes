#!/bin/bash

[[ $verbose != true ]] && devnull=/dev/null || devnull=/dev/stdout
set -e
set -x

# https://wiki.archlinux.org/index.php/Mirrors
echo 'Server = http://mirrors.kernel.org/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist
pacman -Syyu --noconfirm >$devnull

# https://wiki.archlinux.org/index.php/Pacman#Cleaning_the_package_cache
yes | pacman -Scc >$devnull
