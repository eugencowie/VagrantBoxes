#!/bin/bash -ex

# https://www.archlinux.org/pacman/pacman.conf.5.html#_options
sed -i '/#TotalDownload/s/^#//' /etc/pacman.conf
