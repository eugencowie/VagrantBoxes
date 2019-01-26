#!/bin/bash

packer build -only=virtualbox-iso -var init=openrc -var version=20181013 -var boot=70s artixlinux.json \
  && vagrant box add -f artixlinux-openrc artixlinux-openrc-virtualbox.box
