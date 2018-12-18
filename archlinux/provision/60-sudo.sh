#!/bin/bash

set -e
set -x

# https://wiki.archlinux.org/index.php/General_recommendations#Privilege_escalation
pacman -S --noconfirm sudo
echo 'Defaults:vagrant !requiretty' > /etc/sudoers.d/50-vagrant
echo 'vagrant ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers.d/50-vagrant
chmod 440 /etc/sudoers.d/50-vagrant
