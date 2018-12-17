#!/bin/bash

set -e
set -x

# https://www.freedesktop.org/wiki/Software/systemd/PredictableNetworkInterfaceNames/#idontlikethishowdoidisablethis
ln -sf /dev/null /etc/systemd/network/99-default.link
systemctl --quiet enable dhcpcd@eth0
