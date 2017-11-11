#!/bin/bash

if packer build -only=virtualbox-iso -var mirror=http://archlinux.mirrors.uk2.net archlinux-minimal.json; then
   vagrant box add -f archlinux-minimal archlinux-minimal-virtualbox.box
fi