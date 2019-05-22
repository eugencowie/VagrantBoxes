#!/bin/bash

packer build -only=virtualbox-iso -var boot=40s -var version=2019.05.02 -var mirror=http://archlinux.mirrors.uk2.net archlinux.json \
  && vagrant box add -f archlinux archlinux-virtualbox.box
