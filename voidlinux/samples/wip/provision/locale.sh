#!/bin/bash

set -e
set -x

# https://wiki.voidlinux.org/Installation_on_UEFI,_via_chroot#Installing_Void
echo voidlinux > /etc/hostname
echo 'HOSTNAME="voidlinux"' >> /etc/rc.conf
echo 'HARDWARECLOCK="UTC"' >> /etc/rc.conf
echo 'TIMEZONE="UTC"' >> /etc/rc.conf
echo 'KEYMAP="us"' >> /etc/rc.conf

# https://wiki.voidlinux.org/Installation_on_UEFI,_via_chroot#Installing_Void
echo en_US.UTF-8 UTF-8 > /etc/default/libc-locales
xbps-reconfigure -f glibc-locales
