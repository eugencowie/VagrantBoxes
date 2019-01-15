#!/bin/bash

packer build -only=virtualbox-iso -var boot=70s artixlinux-openrc.json \
  && vagrant box add -f artixlinux-openrc artixlinux-openrc-virtualbox.box
