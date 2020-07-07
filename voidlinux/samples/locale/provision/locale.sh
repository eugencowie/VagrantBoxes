#!/bin/bash -ex

# https://docs.voidlinux.org/config/date-time.html#timezone
ln --symbolic --force /usr/share/zoneinfo/Europe/London /etc/localtime

# https://docs.voidlinux.org/config/locales.html#enabling-locales
echo en_GB.UTF-8 UTF-8 >> /etc/default/libc-locales
xbps-reconfigure -f glibc-locales

# https://docs.voidlinux.org/config/locales.html#setting-the-system-locale
sed --in-place 's|^LANG=.*|LANG=en_GB.UTF-8|' /etc/locale.conf
echo KEYMAP=uk >> /etc/rc.conf

# https://docs.voidlinux.org/xbps/repositories/mirrors/changing.html
cp /usr/share/xbps.d/*-repository-*.conf /etc/xbps.d/
for i in /etc/xbps.d/*-repository-*.conf; do echo repository=https://alpha.de.repo.voidlinux.org/current > "$i"; done
xbps-install --yes --sync > /dev/null
