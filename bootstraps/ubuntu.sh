#!/bin/bash

cd ~

apt-get update -y &&
apt-get install -y curl python tar sudo &&
mkdir dotfiles &&
curl -sk https://github.com/LISTERINE/dotfiles/archive/master.tar.gz  | tar xz -C dotfiles --strip-components 1 &&
mv dotfiles .dotfiles &&
cd .dotfiles &&
source install.sh
