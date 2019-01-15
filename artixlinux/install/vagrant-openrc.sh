#!/bin/bash

set -e
set -x

pacman --noconfirm --sync dhcpcd-openrc > /dev/null
rc-update add dhcpcd default > /dev/null

pacman --noconfirm --sync openssh-openrc > /dev/null
rc-update add sshd default > /dev/null
