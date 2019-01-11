#!/bin/bash

set -e
set -x

# https://www.vagrantup.com/docs/boxes/base.html#root-password-quot-vagrant-quot-
echo root:vagrant | chpasswd --crypt-method SHA512

# https://www.vagrantup.com/docs/boxes/base.html#quot-vagrant-quot-user
useradd --create-home vagrant
echo vagrant:vagrant | chpasswd --crypt-method SHA512

# https://www.vagrantup.com/docs/boxes/base.html#password-less-sudo
echo 'Defaults:vagrant !requiretty' > /etc/sudoers.d/50-vagrant
echo 'vagrant ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers.d/50-vagrant
chmod 0440 /etc/sudoers.d/50-vagrant

ln --symbolic /etc/sv/dhcpcd /etc/runit/runsvdir/default/dhcpcd
ln --symbolic /etc/sv/sshd /etc/runit/runsvdir/default/sshd

# https://www.vagrantup.com/docs/boxes/base.html#ssh-tweaks
sed --in-place "/#UseDNS no/s/^#//" /etc/ssh/sshd_config

# https://www.vagrantup.com/docs/boxes/base.html#quot-vagrant-quot-user
xbps-install --yes curl > /dev/null
install --owner=vagrant --group=vagrant --mode=0700 --directory /home/vagrant/.ssh
curl --silent "https://raw.githubusercontent.com/hashicorp/vagrant/master/keys/vagrant.pub" \
  | install --owner=vagrant --group=vagrant --mode=0600 /dev/stdin /home/vagrant/.ssh/authorized_keys
xbps-remove --yes --recursive curl > /dev/null
