#!/bin/bash

set -e
set -x

# https://wiki.archlinux.org/index.php/System_time#Time_zone
timedatectl set-timezone Europe/London

# https://wiki.archlinux.org/index.php/Systemd-timesyncd#Configuration
timedatectl set-ntp true
