#!/bin/bash

[[ $verbose != true ]] && devnull=/dev/null || devnull=/dev/stdout
set -e
set -x

# https://wiki.archlinux.org/index.php/Installation_guide#Localization
echo en_US.UTF-8 UTF-8 > /etc/locale.gen
locale-gen >$devnull
echo LANG=en_US.UTF-8 > /etc/locale.conf
