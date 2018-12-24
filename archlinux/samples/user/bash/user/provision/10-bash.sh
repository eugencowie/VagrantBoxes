#!/bin/bash

set -e
set -x

# https://medium.com/@waxzce/use-bashrc-d-directory-instead-of-bloated-bashrc-50204d5389ff
mkdir -p ~/.bashrc.d
chmod 700 ~/.bashrc.d
echo 'for file in ~/.bashrc.d/*.bashrc; do source "$file"; done' >> ~/.bashrc
