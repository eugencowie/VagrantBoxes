#!/bin/bash

packer build -only=virtualbox-iso -var boot=40s -var mirror=http://archlinux.mirrors.uk2.net archlinux.json \
  && vagrant box add -f archlinux archlinux-virtualbox.box
