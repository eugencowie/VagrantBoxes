#!/bin/bash

packer build -only=virtualbox-iso -var verbose=false -var headless=true -var wait=40s -var mirror=http://archlinux.mirrors.uk2.net archlinux.json \
  && vagrant box add -f archlinux archlinux-virtualbox.box
