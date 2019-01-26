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

# https://wiki.artixlinux.org/Runit/NetworkConfiguration#Dynamic_IP
pacman --noconfirm --sync "dhcpcd-${init:-openrc}" > /dev/null
[[ $init == openrc ]] && rc-update add dhcpcd default > /dev/null
[[ $init == runit  ]] && ln --symbolic /etc/runit/sv/dhcpcd /etc/runit/runsvdir/default/

# https://www.vagrantup.com/docs/boxes/base.html#ssh-tweaks
pacman --noconfirm --sync "openssh-${init:-openrc}" > /dev/null
sed --in-place '/#UseDNS no/s/^#//' /etc/ssh/sshd_config
[[ $init == openrc ]] && rc-update add sshd default > /dev/null
[[ $init == runit  ]] && ln --symbolic /etc/runit/sv/sshd /etc/runit/runsvdir/default/

# https://www.vagrantup.com/docs/boxes/base.html#quot-vagrant-quot-user
sudo -u vagrant bash -ex << 'END'
  mkdir --mode 700 ~/.ssh
  curl --silent 'https://raw.githubusercontent.com/hashicorp/vagrant/master/keys/vagrant.pub' \
    | install --mode=600 /dev/stdin ~/.ssh/authorized_keys
END
