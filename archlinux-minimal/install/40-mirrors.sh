#!/bin/bash

set -e
set -x

mirror="${mirror:-http://mirrors.kernel.org/archlinux}"

# https://wiki.archlinux.org/index.php/Installation_guide#Select_the_mirrors
echo 'Server = '"${mirror}"'/$repo/os/$arch' > /etc/pacman.d/mirrorlist
