#!/bin/bash

set -e
set -x

# https://wiki.archlinux.org/index.php/Locale#Generating_locales
echo en_US.UTF-8 UTF-8 > /etc/locale.gen
locale-gen >/dev/null

# https://wiki.archlinux.org/index.php/Installation_guide#Localization
echo LANG=en_US.UTF-8 > /etc/locale.conf

# https://wiki.archlinux.org/index.php/Installation_guide#Localization
echo KEYMAP=us > /etc/vconsole.conf
