#!/bin/bash

[[ $quiet == true ]] && devnull=/dev/null || devnull=/dev/stdout
[[ $quiet == true ]] && quiet="--quiet"
set -e
set -x

# https://wiki.archlinux.org/index.php/VirtualBox
pacman --sync --noconfirm --asdeps virtualbox-guest-modules-arch >$devnull
pacman --sync --noconfirm virtualbox-guest-utils-nox >$devnull
systemctl $quiet enable vboxservice
