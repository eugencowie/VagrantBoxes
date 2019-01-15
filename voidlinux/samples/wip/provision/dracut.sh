#!/bin/bash

set -e
set -x

# https://wiki.voidlinux.org/Installation_on_UEFI,_via_chroot#Installing_Void
echo 'hostonly="yes"' >> /etc/dracut.conf
echo 'tmpdir=/tmp' >> /etc/dracut.conf
kernel=$(ls -1 /lib/modules | tail -n1)
dracut --force --hostonly --kver "$kernel"
