#!/bin/bash

set -e
set -x

# https://wiki.archlinux.org/index.php/OpenSSH
pacman -S --noconfirm openssh
systemctl --quiet enable sshd

# https://www.vagrantup.com/docs/boxes/base.html#ssh-tweaks
sed -i "/#UseDNS no/s/^#//" /etc/ssh/sshd_config

# https://www.vagrantup.com/docs/boxes/base.html#quot-vagrant-quot-user
mkdir -p /home/vagrant/.ssh
curl -fsSLo /home/vagrant/.ssh/authorized_keys "https://raw.githubusercontent.com/hashicorp/vagrant/master/keys/vagrant.pub"
chown vagrant:vagrant /home/vagrant/.ssh/authorized_keys
chown vagrant:vagrant /home/vagrant/.ssh/
chmod 600 /home/vagrant/.ssh/authorized_keys
chmod 700 /home/vagrant/.ssh/
