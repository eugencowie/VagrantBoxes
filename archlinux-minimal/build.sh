#!/bin/bash

packer build -only=virtualbox-iso \
  -var mirror=http://archlinux.mirrors.uk2.net \
  -var wait=40s \
  archlinux-minimal.json && vagrant box add -f archlinux-minimal archlinux-minimal-virtualbox.box
