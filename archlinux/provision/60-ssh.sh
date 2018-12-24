#!/bin/bash

[[ $verbose != true ]] && devnull=/dev/null || devnull=/dev/stdout
[[ $verbose != true ]] && quiet="--quiet"
[[ $verbose != true ]] && silent="--silent"
set -e
set -x

# https://wiki.archlinux.org/index.php/OpenSSH
pacman -S --noconfirm openssh >$devnull
systemctl $quiet enable sshd

# https://www.vagrantup.com/docs/boxes/base.html#ssh-tweaks
sed -i "/#UseDNS no/s/^#//" /etc/ssh/sshd_config

# https://www.vagrantup.com/docs/boxes/base.html#quot-vagrant-quot-user
install --owner=vagrant --group=vagrant --mode=0700 --directory /home/vagrant/.ssh
curl $silent "https://raw.githubusercontent.com/hashicorp/vagrant/master/keys/vagrant.pub" | install --owner=vagrant --group=vagrant --mode=0600 /dev/stdin /home/vagrant/.ssh/authorized_keys
