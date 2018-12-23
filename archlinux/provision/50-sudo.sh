#!/bin/bash

set -e
set -x

# https://www.vagrantup.com/docs/boxes/base.html#password-less-sudo
pacman -S --noconfirm sudo
echo 'Defaults:vagrant !requiretty' > /etc/sudoers.d/50-vagrant
echo 'vagrant ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers.d/50-vagrant
chmod 0440 /etc/sudoers.d/50-vagrant
