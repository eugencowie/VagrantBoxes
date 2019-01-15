#!/bin/bash

set -e
set -x

pacman --noconfirm --sync dhcpcd-runit > /dev/null
ln --symbolic /etc/runit/sv/dhcpcd /etc/runit/runsvdir/default/

pacman --noconfirm --sync openssh-runit > /dev/null
ln --symbolic /etc/runit/sv/sshd /etc/runit/runsvdir/default/
