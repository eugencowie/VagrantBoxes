#!/bin/bash

[[ $verbose != true ]] && devnull=/dev/null || devnull=/dev/stdout
[[ $verbose != true ]] && quiet="--quiet"
set -e
set -x

# https://wiki.archlinux.org/index.php/VirtualBox
pacman -S --noconfirm --asdeps virtualbox-guest-modules-arch >$devnull
pacman -S --noconfirm virtualbox-guest-utils-nox >$devnull
systemctl $quiet enable vboxservice
