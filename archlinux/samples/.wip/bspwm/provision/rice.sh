#!/bin/bash -ex

# https://wiki.archlinux.org/index.php/Rxvt-unicode#Installation
pacman --noconfirm --sync rxvt-unicode ttf-dejavu sxiv > /dev/null

# https://wiki.archlinux.org/index.php/Bspwm#Configuration
sudo -u vagrant bash -ex << 'END'
  sed --in-place '/^bspc config split_ratio.*/d' ~/.config/bspwm/bspwmrc
  sed --in-place '/^bspc rule.*/d' ~/.config/bspwm/bspwmrc
END

# https://wiki.archlinux.org/index.php/Feh#Installation
pacman --noconfirm --sync feh > /dev/null
sudo -u vagrant bash -ex << 'END'
  echo '
    #!/bin/sh
    feh --bg-fill ~/Pictures/Wallpapers/wallhaven-655985.png
  ' | install --mode=755 /dev/stdin ~/.fehbg
  sed --in-place '/.*exec.*/i ~/.fehbg &' ~/.xinitrc
END
