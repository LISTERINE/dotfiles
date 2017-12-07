#!/bin/bash

# Update packages
sudo $PACKAGE_MAN update -y

# Try to install git and vim
sudo $INSTALL git vim python-pip