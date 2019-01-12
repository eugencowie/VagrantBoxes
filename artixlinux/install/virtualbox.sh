#!/bin/bash

set -e
set -x

pacman --noconfirm --sync --asdeps virtualbox-guest-modules-artix > /dev/null
pacman --noconfirm --sync virtualbox-guest-utils-openrc > /dev/null
rc-update add vboxservice default
