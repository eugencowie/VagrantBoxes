#!/bin/bash

[[ $verbose != true ]] && script="--script"
set -e
set -x

# https://wiki.archlinux.org/index.php/Installation_guide#Partition_the_disks
parted $script /dev/sda mklabel msdos
parted $script /dev/sda mkpart primary ext4 0% 100%
parted $script /dev/sda set 1 boot on
