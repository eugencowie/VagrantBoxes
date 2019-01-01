#!/bin/bash

[[ $quiet == true ]] && devnull=/dev/null || devnull=/dev/stdout
set -e
set -x

# https://wiki.archlinux.org/index.php/GRUB#Installation
pacman --sync --noconfirm grub >$devnull
grub-install /dev/sda 2>$devnull

# https://wiki.archlinux.org/index.php/GRUB#Generate_the_main_configuration_file
sed --in-place 's/^GRUB_TIMEOUT=.*$/GRUB_TIMEOUT=0/' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg 2>$devnull
