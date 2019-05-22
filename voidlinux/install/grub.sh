#!/bin/bash -ex

# https://wiki.voidlinux.org/Installation_via_chroot#Installing_the_Bootloader
xbps-install --yes --sync grub > /dev/null
grub-install /dev/sda 2> /dev/null
sed --in-place 's|^GRUB_TIMEOUT=.*|GRUB_TIMEOUT=0|' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg 2> /dev/null
