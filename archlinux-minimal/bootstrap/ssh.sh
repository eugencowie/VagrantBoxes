#!/bin/bash

set -e
set -x

# https://wiki.archlinux.org/index.php/Users_and_groups#Example_adding_a_user
useradd --create-home vagrant
echo vagrant:vagrant | chpasswd

# https://wiki.archlinux.org/index.php/Sudo#Configure_sudo_using_drop-in_files_in_.2Fetc.2Fsudoers.d
echo 'Defaults:vagrant !requiretty' > /etc/sudoers.d/50-vagrant
echo 'vagrant ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers.d/50-vagrant
chmod 440 /etc/sudoers.d/50-vagrant

# https://wiki.archlinux.org/index.php/Secure_Shell#Daemon_management
systemctl --quiet start sshd
