#!/bin/bash

# Update packages
sudo {{PACKAGE_MAN}} -y update

# Try to install git and vim
sudo {{PACKAGE_MAN}} install -y git vim python-pip