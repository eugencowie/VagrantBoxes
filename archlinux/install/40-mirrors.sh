#!/bin/bash

set -e
set -x

# https://wiki.archlinux.org/index.php/Installation_guide#Select_the_mirrors
echo "Server = ${mirror:-http://mirrors.kernel.org/archlinux}"'/$repo/os/$arch' > /etc/pacman.d/mirrorlist
