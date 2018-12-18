#!/bin/bash

set -e
set -x

# https://wiki.archlinux.org/index.php/General_recommendations#Users_and_groups
useradd --create-home vagrant
echo vagrant:vagrant | chpasswd
