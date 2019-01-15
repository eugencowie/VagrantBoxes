#!/bin/bash

packer build -only=virtualbox-iso -var boot=25s artixlinux-runit.json \
  && vagrant box add -f artixlinux-runit artixlinux-runit-virtualbox.box
