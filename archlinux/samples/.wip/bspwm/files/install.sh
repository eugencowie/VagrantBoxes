#!/bin/bash -ex

sudo -u vagrant bash -ex << 'END'
  mkdir --parents ~/Pictures/Wallpapers
  cp --no-preserve=mode {/vagrant/files/home/vagrant,~}/Pictures/Wallpapers/wallhaven-655985.png
END
