#!/bin/bash

set -e
set -x

# https://unix.stackexchange.com/questions/145332/difference-between-sdx-and-vdx/145336#145336
if   [ -e /dev/vda ]; then device=/dev/vda
elif [ -e /dev/sda ]; then device=/dev/sda
else exit 1; fi

# https://wiki.archlinux.org/index.php/Installation_guide#Mount_the_file_systems
mount "${device}1" /mnt
