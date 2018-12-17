#!/bin/bash

set -e
set -x

# https://unix.stackexchange.com/questions/145332/difference-between-sdx-and-vdx/145336#145336
if   [ -e /dev/vda ]; then device=/dev/vda
elif [ -e /dev/sda ]; then device=/dev/sda
else exit 1; fi

# https://wiki.archlinux.org/index.php/Installation_guide#Time_zone
ln -sf /usr/share/zoneinfo/UTC /etc/localtime
hwclock --systohc

# https://wiki.archlinux.org/index.php/Installation_guide#Locale
echo en_US.UTF-8 UTF-8 > /etc/locale.gen
locale-gen >/dev/null
echo LANG=en_US.UTF-8 > /etc/locale.conf
echo KEYMAP=us > /etc/vconsole.conf

# https://wiki.archlinux.org/index.php/Installation_guide#Hostname
echo archlinux > /etc/hostname

# https://wiki.archlinux.org/index.php/GRUB#Installation
grub-install "$device"
sed -i 's/^GRUB_TIMEOUT=.*$/GRUB_TIMEOUT=0/' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

# https://wiki.archlinux.org/index.php/Users_and_groups#Example_adding_a_user
useradd --create-home vagrant
echo vagrant:vagrant | chpasswd

# https://wiki.archlinux.org/index.php/Sudo#Configure_sudo_using_drop-in_files_in_.2Fetc.2Fsudoers.d
echo 'Defaults:vagrant !requiretty' > /etc/sudoers.d/50-vagrant
echo 'vagrant ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers.d/50-vagrant
chmod 440 /etc/sudoers.d/50-vagrant

# https://www.freedesktop.org/wiki/Software/systemd/PredictableNetworkInterfaceNames/#idontlikethishowdoidisablethis
ln -sf /dev/null /etc/systemd/network/99-default.link
systemctl --quiet enable dhcpcd@eth0

# https://wiki.archlinux.org/index.php/Secure_Shell#Daemon_management
systemctl --quiet enable sshd
