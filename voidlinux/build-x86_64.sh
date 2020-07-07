#!/bin/bash

packer build -only=virtualbox-iso -var arch=x86_64 -var version=20191109 -var mirror=https://alpha.de.repo.voidlinux.org voidlinux.json \
  && vagrant box add -f voidlinux-x86_64 voidlinux-x86_64-virtualbox.box
