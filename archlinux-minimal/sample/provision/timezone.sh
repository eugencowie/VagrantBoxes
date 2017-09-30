#!/bin/bash

set -e
set -x

# https://wiki.archlinux.org/index.php/Time#Time_zone
timedatectl set-timezone Europe/London

# https://wiki.archlinux.org/index.php/Systemd-timesyncd#Installation
timedatectl set-ntp true
