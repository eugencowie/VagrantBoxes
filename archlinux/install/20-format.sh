#!/bin/bash

[[ $quiet == true ]] && q="-q"
set -e
set -x

# https://wiki.archlinux.org/index.php/Installation_guide#Format_the_partitions
mkfs.ext4 $q /dev/sda1
