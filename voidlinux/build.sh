#!/bin/bash

packer build -only=virtualbox-iso -var mirror=http://alpha.de.repo.voidlinux.org voidlinux.json \
  && vagrant box add -f voidlinux voidlinux-virtualbox.box
