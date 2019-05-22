#!/bin/bash -ex

# https://www.vagrantup.com/docs/boxes/base.html#root-password-quot-vagrant-quot-
echo root:vagrant | chpasswd --crypt-method SHA512

# https://www.vagrantup.com/docs/boxes/base.html#quot-vagrant-quot-user
useradd --create-home vagrant
echo vagrant:vagrant | chpasswd --crypt-method SHA512

# https://www.vagrantup.com/docs/boxes/base.html#password-less-sudo
echo 'Defaults:vagrant !requiretty' > /etc/sudoers.d/50-vagrant
echo 'vagrant ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers.d/50-vagrant
chmod 440 /etc/sudoers.d/50-vagrant

# https://wiki.voidlinux.org/Network_Configuration#DHCP_per_interface
mkdir --parents /etc/udev/rules.d
ln --symbolic --force /dev/null /etc/udev/rules.d/80-net-setup-link.rules # TODO
mkdir --parents /etc/sv/dhcpcd-eth0
echo '#!/bin/sh' > /etc/sv/dhcpcd-eth0/run
echo 'exec dhcpcd -B eth0' >> /etc/sv/dhcpcd-eth0/run
chmod 755 /etc/sv/dhcpcd-eth0/run
ln --symbolic --force /run/runit/supervise.dhcpcd-eth0 /etc/sv/dhcpcd-eth0/supervise
ln --symbolic /etc/sv/dhcpcd-eth0 /etc/runit/runsvdir/default/

# https://www.vagrantup.com/docs/boxes/base.html#ssh-tweaks
sed --in-place '|#UseDNS no|s|^#||' /etc/ssh/sshd_config
ln --symbolic /etc/sv/sshd /etc/runit/runsvdir/default/

# https://www.vagrantup.com/docs/boxes/base.html#quot-vagrant-quot-user
xbps-install --yes curl > /dev/null
sudo -u vagrant bash -ex << 'END'
  mkdir --mode 700 ~/.ssh
  curl --silent 'https://raw.githubusercontent.com/hashicorp/vagrant/master/keys/vagrant.pub' \
    | install --mode=600 /dev/stdin ~/.ssh/authorized_keys
END
xbps-remove --yes --recursive curl > /dev/null
