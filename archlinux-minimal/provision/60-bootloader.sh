#!/bin/bash

set -e
set -x

# https://unix.stackexchange.com/questions/145332/difference-between-sdx-and-vdx/145336#145336
if   [ -e /dev/vda ]; then device=/dev/vda
elif [ -e /dev/sda ]; then device=/dev/sda
else exit 1; fi

# https://wiki.archlinux.org/index.php/GRUB#Installation
pacman -S --noconfirm grub
grub-install "$device"
sed -i 's/^GRUB_TIMEOUT=.*$/GRUB_TIMEOUT=0/' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg
