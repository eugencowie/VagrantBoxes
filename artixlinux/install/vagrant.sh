#!/bin/bash

set -e
set -x

# https://www.vagrantup.com/docs/boxes/base.html#root-password-quot-vagrant-quot-
echo root:vagrant | chpasswd

# https://www.vagrantup.com/docs/boxes/base.html#quot-vagrant-quot-user
useradd --create-home vagrant
echo vagrant:vagrant | chpasswd

# https://www.vagrantup.com/docs/boxes/base.html#password-less-sudo
pacman --noconfirm --sync sudo > /dev/null
echo 'Defaults:vagrant !requiretty' > /etc/sudoers.d/50-vagrant
echo 'vagrant ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers.d/50-vagrant
chmod 0440 /etc/sudoers.d/50-vagrant

# https://wiki.artixlinux.org/Runit/NetworkConfiguration#Dynamic_IP
pacman --noconfirm --sync dhcpcd-openrc > /dev/null
rc-update add dhcpcd default

# https://wiki.artixlinux.org/Main/OpenRC#Adding.2Fremoving_services_to.2Ffrom_runlevels
pacman --noconfirm --sync openssh-openrc > /dev/null
rc-update add sshd default

# https://www.vagrantup.com/docs/boxes/base.html#ssh-tweaks
sed --in-place "/#UseDNS no/s/^#//" /etc/ssh/sshd_config

# https://www.vagrantup.com/docs/boxes/base.html#quot-vagrant-quot-user
install --owner=vagrant --group=vagrant --mode=0700 --directory /home/vagrant/.ssh
curl --silent "https://raw.githubusercontent.com/hashicorp/vagrant/master/keys/vagrant.pub" \
  | install --owner=vagrant --group=vagrant --mode=0600 /dev/stdin /home/vagrant/.ssh/authorized_keys
