#!/bin/bash

set -e
set -x

# https://wiki.archlinux.org/index.php/Bspwm#Installation
pacman --noconfirm --sync bspwm > /dev/null
install --owner=vagrant --group=vagrant --directory /home/vagrant/.config/bspwm
install --owner=vagrant --group=vagrant /usr/share/doc/bspwm/examples/bspwmrc /home/vagrant/.config/bspwm/bspwmrc

# https://wiki.archlinux.org/index.php/Sxhkd#Installation
pacman --noconfirm --sync sxhkd > /dev/null
install --owner=vagrant --group=vagrant --directory /home/vagrant/.config/sxhkd
install --owner=vagrant --group=vagrant /usr/share/doc/bspwm/examples/sxhkdrc /home/vagrant/.config/sxhkd/sxhkdrc

# https://wiki.archlinux.org/index.php/Xinit#xinitrc
sed --in-place --regexp-extended '/.*(twm|xclock|xterm).*/d' /home/vagrant/.xinitrc
echo 'exec bspwm' >> /home/vagrant/.xinitrc

# https://wiki.archlinux.org/index.php/Rxvt-unicode#Installation
pacman --noconfirm --sync rxvt-unicode ttf-dejavu > /dev/null
