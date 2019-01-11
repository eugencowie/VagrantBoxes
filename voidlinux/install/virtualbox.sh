#!/bin/bash

set -e
set -x

[[ $arch == x86_64-musl ]] && exit

# https://wiki.voidlinux.org/VirtualBox#Running_Void_as_guest_on_VirtualBox_.28VM.29
xbps-install --yes virtualbox-ose-guest > /dev/null
ln --symbolic /etc/sv/vboxservce /etc/runit/runsvdir/default/vboxservice
