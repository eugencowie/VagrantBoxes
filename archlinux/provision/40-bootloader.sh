#!/bin/bash

set -e
set -x

# https://wiki.archlinux.org/index.php/Installation_guide#Boot_loader
pacman -S --noconfirm grub
grub-install /dev/sda
sed -i 's/^GRUB_TIMEOUT=.*$/GRUB_TIMEOUT=0/' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg
