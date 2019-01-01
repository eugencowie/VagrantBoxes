#!/bin/bash

[[ $quiet == true ]] && devnull=/dev/null || devnull=/dev/stdout
set -e
set -x

# https://wiki.archlinux.org/index.php/Locale#Generating_locales
echo en_GB.UTF-8 UTF-8 > /etc/locale.gen
locale-gen >$devnull

# https://wiki.archlinux.org/index.php/Locale#Setting_the_system_locale
localectl set-locale LANG=en_GB.UTF-8

# https://wiki.archlinux.org/index.php/Keyboard_configuration_in_console#Persistent_configuration
localectl set-keymap --no-convert uk
