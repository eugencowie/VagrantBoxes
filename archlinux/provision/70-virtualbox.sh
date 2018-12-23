#!/bin/bash

set -e
set -x

# https://wiki.archlinux.org/index.php/VirtualBox
pacman -S --noconfirm --asdeps virtualbox-guest-modules-arch
pacman -S --noconfirm virtualbox-guest-utils-nox
systemctl --quiet enable vboxservice
