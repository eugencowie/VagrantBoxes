#!/bin/bash -ex

# https://wiki.archlinux.org/index.php/Bspwm#Installation
pacman --noconfirm --sync bspwm > /dev/null
sudo -u vagrant bash -ex << 'END'
  mkdir --parents ~/.config/bspwm
  cp /usr/share/doc/bspwm/examples/bspwmrc ~/.config/bspwm/bspwmrc
END

# https://wiki.archlinux.org/index.php/Sxhkd#Installation
pacman --noconfirm --sync sxhkd > /dev/null
sudo -u vagrant bash -ex << 'END'
  mkdir --parents ~/.config/sxhkd
  cp /usr/share/doc/bspwm/examples/sxhkdrc ~/.config/sxhkd/sxhkdrc
END

# https://wiki.archlinux.org/index.php/Xinit#xinitrc
sudo -u vagrant bash -ex << 'END'
  sed --in-place --regexp-extended '/.*(twm|xclock|xterm).*/d' ~/.xinitrc
  echo 'exec bspwm' >> ~/.xinitrc
END
