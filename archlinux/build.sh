#!/bin/bash

packer build -only=virtualbox-iso -var mirror=http://archlinux.mirrors.uk2.net -var boot=40s -var headless=true -var quiet=true archlinux.json \
  && vagrant box add -f archlinux archlinux-virtualbox.box
