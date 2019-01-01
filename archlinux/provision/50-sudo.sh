#!/bin/bash

[[ $quiet == true ]] && devnull=/dev/null || devnull=/dev/stdout
set -e
set -x

# https://www.vagrantup.com/docs/boxes/base.html#password-less-sudo
pacman --sync --noconfirm sudo >$devnull
echo 'Defaults:vagrant !requiretty' > /etc/sudoers.d/50-vagrant
echo 'vagrant ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers.d/50-vagrant
chmod 0440 /etc/sudoers.d/50-vagrant
