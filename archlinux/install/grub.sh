#!/bin/bash -ex

# https://wiki.archlinux.org/index.php/GRUB#Installation
pacman --noconfirm --sync grub > /dev/null
grub-install /dev/sda 2> /dev/null

# https://wiki.archlinux.org/index.php/GRUB#Generate_the_main_configuration_file
sed --in-place 's/^GRUB_TIMEOUT=.*/GRUB_TIMEOUT=0/' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg 2> /dev/null
