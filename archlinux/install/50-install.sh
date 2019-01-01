#!/bin/bash

[[ $quiet == true ]] && devnull=/dev/null || devnull=/dev/stdout
set -e
set -x

# https://wiki.archlinux.org/index.php/Installation_guide#Install_the_base_packages
pacstrap /mnt base >$devnull
