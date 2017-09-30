#!/bin/bash

set -e
set -x

# https://www.vagrantup.com/docs/boxes/base.html#quot-vagrant-quot-user
mkdir -p ~/.ssh
curl -fsSLo ~/.ssh/authorized_keys "https://raw.githubusercontent.com/hashicorp/vagrant/master/keys/vagrant.pub"
chmod 600 ~/.ssh/authorized_keys
chmod 700 ~/.ssh/

# https://www.vagrantup.com/docs/boxes/base.html#ssh-tweaks
sudo sed -i "/#UseDNS no/s/^#//" /etc/ssh/sshd_config
