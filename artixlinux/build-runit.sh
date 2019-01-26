#!/bin/bash

packer build -only=virtualbox-iso -var init=runit -var version=20180604 -var boot=25s artixlinux.json \
  && vagrant box add -f artixlinux-runit artixlinux-runit-virtualbox.box
