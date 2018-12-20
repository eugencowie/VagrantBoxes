#!/bin/bash

set -e
set -x

# https://wiki.archlinux.org/index.php/Fish#Installation
sudo pacman -S --noconfirm fish

# https://wiki.archlinux.org/index.php/Fish#Modify_.bashrc_to_drop_into_fish
echo 'if [ -z "$BASH_EXECUTION_STRING" ]; then exec fish; fi' >> ~/.bashrc
