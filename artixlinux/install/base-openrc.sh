#!/bin/bash

set -e
set -x

# https://wiki.artixlinux.org/Main/Installation#Install_base_system
(set -o pipefail; (basestrap /mnt base openrc 3>&1 1>/dev/null 2>&3 | sed --unbuffered --regexp-extended '/^ --> u?mount: .*/d') 1>&2)
fstabgen -U /mnt >> /mnt/etc/fstab
