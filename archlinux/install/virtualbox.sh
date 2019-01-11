#!/bin/bash

set -e
set -x

# https://wiki.archlinux.org/index.php/VirtualBox#Install_the_Guest_Additions
pacman --noconfirm --sync --asdeps virtualbox-guest-modules-arch > /dev/null
pacman --noconfirm --sync virtualbox-guest-utils-nox > /dev/null
systemctl --quiet enable vboxservice
