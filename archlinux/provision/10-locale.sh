#!/bin/bash

set -e
set -x

# https://wiki.archlinux.org/index.php/Installation_guide#Localization
echo en_US.UTF-8 UTF-8 > /etc/locale.gen
locale-gen >/dev/null
echo LANG=en_US.UTF-8 > /etc/locale.conf
