#!/bin/bash

set -e
set -x

# https://wiki.archlinux.org/index.php/Users_and_groups#Example_adding_a_user
useradd --create-home vagrant
echo vagrant:vagrant | chpasswd

# https://wiki.archlinux.org/index.php/Sudo#Installation
pacman -S --noconfirm sudo

# https://wiki.archlinux.org/index.php/Sudo#Configure_sudo_using_drop-in_files_in_.2Fetc.2Fsudoers.d
echo 'Defaults:vagrant !requiretty' > /etc/sudoers.d/50-vagrant
echo 'vagrant ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers.d/50-vagrant
chmod 440 /etc/sudoers.d/50-vagrant

# https://wiki.archlinux.org/index.php/OpenSSH#Installation
pacman -S --noconfirm openssh

# https://www.vagrantup.com/docs/boxes/base.html#quot-vagrant-quot-user
su - vagrant -c 'mkdir -p ~/.ssh'
su - vagrant -c 'curl -fsSLo ~/.ssh/authorized_keys "https://raw.githubusercontent.com/hashicorp/vagrant/master/keys/vagrant.pub"'
su - vagrant -c 'chmod 600 ~/.ssh/authorized_keys'
su - vagrant -c 'chmod 700 ~/.ssh/'

# https://www.vagrantup.com/docs/boxes/base.html#ssh-tweaks
sed -i "/#UseDNS no/s/^#//" /etc/ssh/sshd_config

# https://wiki.archlinux.org/index.php/Secure_Shell#Daemon_management
systemctl --quiet enable sshd
