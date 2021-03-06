#!/bin/bash -ex

[[ $arch == x86_64-musl ]] && exit

# https://wiki.voidlinux.org/VirtualBox#Running_Void_as_guest_on_VirtualBox_.28VM.29
xbps-install --yes dbus > /dev/null
ln --symbolic /etc/sv/dbus /etc/runit/runsvdir/default/

# https://wiki.voidlinux.org/VirtualBox#Running_Void_as_guest_on_VirtualBox_.28VM.29
xbps-install --yes virtualbox-ose-guest > /dev/null
ln --symbolic /etc/sv/vboxservice /etc/runit/runsvdir/default/
