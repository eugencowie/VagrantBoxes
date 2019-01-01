#!/bin/bash

set -e
set -x

sudo pacman -Syu

# https://wiki.archlinux.org/index.php/Arch_User_Repository#Prerequisites
sudo pacman -S --noconfirm --needed base-devel

#
sudo pacman -S --noconfirm ttf-dejavu rxvt-unicode

# https://wiki.archlinux.org/index.php/Sway#Installation
curl 'https://aur.archlinux.org/cgit/aur.git/snapshot/wlroots-git.tar.gz' | tar --extract --ungzip
curl 'https://aur.archlinux.org/cgit/aur.git/snapshot/sway-git.tar.gz' | tar --extract --ungzip
(cd wlroots-git && makepkg --syncdeps --rmdeps --clean --install --noconfirm)
(cd sway-git && makepkg --syncdeps --rmdeps --clean --install --noconfirm)

# https://wiki.archlinux.org/index.php/Sway#Autostart_on_login
echo 'if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then exec sway; fi' >> ~/.bash_profile
