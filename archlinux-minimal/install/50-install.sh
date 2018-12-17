#!/bin/bash

set -e
set -x

# https://wiki.archlinux.org/index.php/Installation_guide#Install_the_base_packages
pacstrap /mnt base
