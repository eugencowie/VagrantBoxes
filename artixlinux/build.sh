#!/bin/bash

packer build -only=virtualbox-iso -var boot=70s artixlinux.json \
  && vagrant box add -f artixlinux artixlinux-virtualbox.box
