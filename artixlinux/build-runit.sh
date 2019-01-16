#!/bin/bash

packer build -only=virtualbox-iso -var version=20180604 -var init=runit -var boot=25s artixlinux.json \
  && vagrant box add -f artixlinux-runit artixlinux-runit-virtualbox.box
