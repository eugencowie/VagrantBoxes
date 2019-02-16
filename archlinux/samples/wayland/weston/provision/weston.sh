#!/bin/bash -ex

# https://wiki.archlinux.org/index.php/Wayland#Installation
pacman --noconfirm --sync weston ttf-dejavu > /dev/null

# https://wiki.archlinux.org/index.php/Xinit#Autostart_X_at_login
sudo -u vagrant bash -ex << 'END'
  echo '[[ ! $DISPLAY && $XDG_VTNR -eq 1 ]] && exec weston' >> ~/.bash_profile
END

# https://wiki.archlinux.org/index.php/Getty#Automatic_login_to_virtual_console
mkdir --parents /etc/systemd/system/getty@tty1.service.d
cat << 'END' > /etc/systemd/system/getty@tty1.service.d/autologin.conf
  [Service]
  ExecStart=
  ExecStart=-/usr/bin/agetty --autologin vagrant --noclear %I $TERM
END
systemctl --quiet daemon-reload
