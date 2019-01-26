#!/bin/bash -ex

# https://wiki.archlinux.org/index.php/Pacman#Cleaning_the_package_cache
yes | pacman --sync --clean --clean > /dev/null
