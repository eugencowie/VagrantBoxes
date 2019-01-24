#!/bin/bash -ex

# https://www.vagrantup.com/docs/boxes/base.html#root-password-quot-vagrant-quot-
echo root:vagrant | chpasswd

# https://www.vagrantup.com/docs/boxes/base.html#quot-vagrant-quot-user
useradd --create-home vagrant
echo vagrant:vagrant | chpasswd

# https://www.vagrantup.com/docs/boxes/base.html#password-less-sudo
pacman --noconfirm --sync sudo > /dev/null
echo 'Defaults:vagrant !requiretty' > /etc/sudoers.d/50-vagrant
echo 'vagrant ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers.d/50-vagrant
chmod 440 /etc/sudoers.d/50-vagrant

# https://wiki.archlinux.org/index.php/Network_configuration#Revert_to_traditional_interface_names
ln --symbolic --force /dev/null /etc/udev/rules.d/80-net-setup-link.rules
systemctl --quiet enable dhcpcd@eth0

# https://www.vagrantup.com/docs/boxes/base.html#ssh-tweaks
pacman --noconfirm --sync openssh > /dev/null
sed --in-place '/#UseDNS no/s/^#//' /etc/ssh/sshd_config
systemctl --quiet enable sshd

# https://www.vagrantup.com/docs/boxes/base.html#quot-vagrant-quot-user
sudo -u vagrant bash -ex << 'END'
  mkdir --mode 700 ~/.ssh
  curl --silent 'https://raw.githubusercontent.com/hashicorp/vagrant/master/keys/vagrant.pub' \
    | install --mode=600 /dev/stdin ~/.ssh/authorized_keys
END
