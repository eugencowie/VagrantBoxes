#!/bin/bash -ex

# https://wiki.archlinux.org/index.php/Xorg#Installation
pacman --noconfirm --sync xorg-server > /dev/null

# https://wiki.archlinux.org/index.php/Xinit#Autostart_X_at_login
pacman --noconfirm --sync xorg-xinit > /dev/null
sudo -u vagrant bash -ex << 'END'
  cp /etc/X11/xinit/xinitrc ~/.xinitrc
  echo '[[ ! $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx' >> ~/.bash_profile
END

# https://wiki.archlinux.org/index.php/VirtualBox#Install_the_Guest_Additions
pacman --noconfirm --remove virtualbox-guest-utils-nox > /dev/null
pacman --noconfirm --sync virtualbox-guest-utils > /dev/null
sudo -u vagrant bash -ex << 'END'
  sed --in-place '/.*exec.*/i VBoxClient-all &' ~/.xinitrc
END

# https://wiki.archlinux.org/index.php/Getty#Automatic_login_to_virtual_console
mkdir --parents /etc/systemd/system/getty@tty1.service.d
cat << 'END' > /etc/systemd/system/getty@tty1.service.d/autologin.conf
  [Service]
  ExecStart=
  ExecStart=-/usr/bin/agetty --autologin vagrant --noclear %I $TERM
END
systemctl --quiet daemon-reload
