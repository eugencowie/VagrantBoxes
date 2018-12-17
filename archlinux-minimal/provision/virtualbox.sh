#!/bin/bash

set -e
set -x

[[ "$PACKER_BUILDER_TYPE" != "virtualbox-iso" ]] && exit 0

# https://wiki.archlinux.org/index.php/VirtualBox#Install_the_Guest_Additions
pacman -S --noconfirm --asdeps virtualbox-guest-modules-arch
pacman -S --noconfirm virtualbox-guest-utils-nox

# https://wiki.archlinux.org/index.php/VirtualBox#Load_the_VirtualBox_kernel_modules_2
systemctl --quiet enable vboxservice
