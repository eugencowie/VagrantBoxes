#!/bin/bash

set -e
set -x

# https://wiki.archlinux.org/index.php/GRUB#Installation
pacman -S --noconfirm grub
grub-install /dev/sda

# https://wiki.archlinux.org/index.php/GRUB#Generate_the_main_configuration_file
sed -i 's/^GRUB_TIMEOUT=.*$/GRUB_TIMEOUT=0/' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg
