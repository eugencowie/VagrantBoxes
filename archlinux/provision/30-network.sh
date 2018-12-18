#!/bin/bash

set -e
set -x

# https://www.freedesktop.org/wiki/Software/systemd/PredictableNetworkInterfaceNames/#idontlikethishowdoidisablethis
ln -sf /dev/null /etc/systemd/network/99-default.link

# https://wiki.archlinux.org/index.php/Installation_guide#Network_configuration
echo archlinux > /etc/hostname
systemctl --quiet enable dhcpcd@eth0
