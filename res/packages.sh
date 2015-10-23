#!/bin/bash

# Update packages
sudo $PACKAGE_MAN -y update

# Try to install git and vim
sudo $INSTALL git vim python-pip