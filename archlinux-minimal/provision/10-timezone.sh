#!/bin/bash

set -e
set -x

# https://wiki.archlinux.org/index.php/Installation_guide#Time_zone
ln -sf /usr/share/zoneinfo/UTC /etc/localtime
hwclock --systohc
