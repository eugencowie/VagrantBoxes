#!/bin/bash

set -e
set -x

# https://wiki.archlinux.org/index.php/System_time#Time_zone
timedatectl set-timezone Europe/London

# https://wiki.archlinux.org/index.php/Locale#Generating_locales
echo en_GB.UTF-8 UTF-8 > /etc/locale.gen
locale-gen > /dev/null
localectl set-locale LANG=en_GB.UTF-8
localectl set-keymap --no-convert uk

# https://wiki.archlinux.org/index.php/Mirrors#Enabling_a_specific_mirror
echo 'Server = http://archlinux.mirrors.uk2.net/$repo/os/$arch' > /etc/pacman.d/mirrorlist
pacman --noconfirm --sync --refresh --refresh --sysupgrade --sysupgrade > /dev/null
