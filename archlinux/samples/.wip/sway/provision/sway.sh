#!/bin/bash

set -e
set -x

sudo pacman --noconfirm --sync --refresh --sysupgrade > /dev/null

sudo pacman --noconfirm --remove virtualbox-guest-utils-nox > /dev/null
sudo pacman --noconfirm --sync virtualbox-guest-utils > /dev/null
sudo systemctl --quiet enable vboxservice
sudo systemctl --quiet start vboxservice

# https://wiki.archlinux.org/index.php/Arch_User_Repository#Prerequisites
sudo pacman --noconfirm --sync --needed base-devel > /dev/null

# https://wiki.archlinux.org/index.php/Sway#Installation
curl --silent 'https://aur.archlinux.org/cgit/aur.git/snapshot/wlroots-git.tar.gz' | tar --extract --ungzip
(set -o pipefail; (cd wlroots-git \
  && makepkg --noconfirm --syncdeps --install --clean --rmdeps 3>&1 1>/dev/null 2>&3 \
  | sed --unbuffered --regexp-extended '/^(==>|  ->|Cloning|done|    wlroots).*/d') 1>&2)
rm --recursive --force wlroots-git

curl --silent 'https://aur.archlinux.org/cgit/aur.git/snapshot/sway-git.tar.gz' | tar --extract --ungzip
(set -o pipefail; (cd sway-git \
  && makepkg --noconfirm --syncdeps --install --clean --rmdeps 3>&1 1>/dev/null 2>&3 \
  | sed --unbuffered --regexp-extended '/^(==>|  ->|Cloning|done|    sway).*/d') 1>&2)
rm --recursive --force sway-git

sudo pacman --noconfirm --sync ttf-dejavu rxvt-unicode > /dev/null

# https://wiki.archlinux.org/index.php/Sway#Autostart_on_login
echo 'if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then exec sway; fi' >> ~/.bash_profile
