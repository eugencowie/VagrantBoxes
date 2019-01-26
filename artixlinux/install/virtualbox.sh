#!/bin/bash -ex

pacman --noconfirm --sync --asdeps virtualbox-guest-modules-artix > /dev/null
pacman --noconfirm --sync virtualbox-guest-utils-nox > /dev/null
