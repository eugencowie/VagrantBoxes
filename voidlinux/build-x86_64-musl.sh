#!/bin/bash

packer build -only=virtualbox-iso -var arch=x86_64-musl -var version=20181111 -var mirror=http://alpha.de.repo.voidlinux.org voidlinux.json \
  && vagrant box add -f voidlinux-x86_64-musl voidlinux-x86_64-musl-virtualbox.box
