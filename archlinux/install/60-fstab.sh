#!/bin/bash

set -e
set -x

# https://wiki.archlinux.org/index.php/Installation_guide#Fstab
genfstab -U /mnt >> /mnt/etc/fstab