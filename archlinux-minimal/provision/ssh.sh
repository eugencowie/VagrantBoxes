#!/bin/bash

set -e
set -x

# https://www.vagrantup.com/docs/boxes/base.html#quot-vagrant-quot-user
su - vagrant -c 'mkdir -p ~/.ssh'
su - vagrant -c 'curl -fsSLo ~/.ssh/authorized_keys "https://raw.githubusercontent.com/hashicorp/vagrant/master/keys/vagrant.pub"'
su - vagrant -c 'chmod 600 ~/.ssh/authorized_keys'
su - vagrant -c 'chmod 700 ~/.ssh/'

# https://www.vagrantup.com/docs/boxes/base.html#ssh-tweaks
sed -i "/#UseDNS no/s/^#//" /etc/ssh/sshd_config
