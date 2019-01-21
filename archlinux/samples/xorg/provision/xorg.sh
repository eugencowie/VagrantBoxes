#!/bin/bash

set -e
set -x

# https://wiki.archlinux.org/index.php/Xorg#Installation
pacman --noconfirm --sync xorg-server > /dev/null

# https://wiki.archlinux.org/index.php/Xinit#Installation
pacman --noconfirm --sync xorg-xinit > /dev/null
install --owner=vagrant --group=vagrant /etc/X11/xinit/xinitrc /home/vagrant/.xinitrc
echo '[[ ! $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx' >> /home/vagrant/.bash_profile

# https://wiki.archlinux.org/index.php/VirtualBox#Install_the_Guest_Additions
pacman --noconfirm --remove virtualbox-guest-utils-nox > /dev/null
pacman --noconfirm --sync virtualbox-guest-utils > /dev/null
sed --in-place '/.*exec.*/i VBoxClient-all &' /home/vagrant/.xinitrc

# https://wiki.archlinux.org/index.php/Getty#Automatic_login_to_virtual_console
mkdir --parents /etc/systemd/system/getty@tty1.service.d
echo $'[Service]\nExecStart=\nExecStart=-/usr/bin/agetty --autologin vagrant --noclear %I $TERM' \
  >> /etc/systemd/system/getty@tty1.service.d/override.conf
systemctl --quiet daemon-reload
