#!/bin/bash

cd ~

yum update -y
yum install -y curl python tar
mkdir dotfiles
curl -sk https://github.com/LISTERINE/dotfiles/archive/master.tar.gz  | tar xz -C dotfiles --strip-components 1
mv dotfiles .dotfiles
cd .dotfiles
source install.sh
