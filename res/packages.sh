#!/bin/bash

# Update packages
$PACKAGE_MAN -y update

# Try to install git and vim
$INSTALL git vim