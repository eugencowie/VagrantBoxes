#!/bin/bash -ex

# https://www.vagrantup.com/docs/boxes/base.html#root-password-vagrant
echo root:vagrant | chpasswd --crypt-method SHA512

# https://www.vagrantup.com/docs/boxes/base.html#vagrant-user
useradd vagrant
echo vagrant:vagrant | chpasswd --crypt-method SHA512

# https://www.vagrantup.com/docs/boxes/base.html#password-less-sudo
echo 'Defaults:vagrant !requiretty' > /etc/sudoers.d/00-vagrant
echo 'vagrant ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers.d/00-vagrant
chmod 440 /etc/sudoers.d/00-vagrant

# https://docs.voidlinux.org/config/network/index.html#interface-names
sed --in-place '\|GRUB_CMDLINE_LINUX_DEFAULT|s|="|="net.ifnames=0 |' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg 2> /dev/null
ln --symbolic /etc/sv/dhcpcd-eth0 /etc/runit/runsvdir/default/

# https://www.vagrantup.com/docs/boxes/base.html#ssh-tweaks
sed --in-place '|#UseDNS no|s|#||' /etc/ssh/sshd_config
ln --symbolic /etc/sv/sshd /etc/runit/runsvdir/default/

# https://www.vagrantup.com/docs/boxes/base.html#vagrant-user
xbps-install --yes curl > /dev/null
sudo -u vagrant bash -ex << 'END'
  mkdir --mode 700 ~/.ssh
  curl --silent 'https://raw.githubusercontent.com/hashicorp/vagrant/master/keys/vagrant.pub' \
    | install --mode=600 /dev/stdin ~/.ssh/authorized_keys
END
xbps-remove --yes --recursive curl > /dev/null
