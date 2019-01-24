#!/bin/bash -ex

# https://wiki.archlinux.org/index.php/Twm#Installation
pacman --noconfirm --sync xorg-twm xorg-xclock xterm > /dev/null
