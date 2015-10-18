#!/bin/bash

# Determine platform
# This imports sys.stdout.write and uses it to output the OS name as returned by
# pythons platform.dist() function
export platform=$(python -c "__import__('sys').stdout.write(__import__('platform').dist()[0].lower())")

case $platform in
debian)
    export SSL_CERT_DIR="/etc/ssl/certs/"
    export CA_CERT_DIR="/usr/local/share/ca-certificates/"
    export PACKAGE_MAN="apt-get"
    export INSTALL="$PACKAGE_MAN install -y"
    export PACKAGE_CONF_DIR="/etc/apt/"
    export PACKAGE_CONF_FILE="apt.conf"
    export CA_UPDATER="update-ca-certificates"
    export extra_files="";
    ;;
ubuntu)
    export SSL_CERT_DIR="/etc/ssl/certs/"
    export CA_CERT_DIR="/usr/local/share/ca-certificates/"
    export PACKAGE_MAN="apt-get"
    export INSTALL="$PACKAGE_MAN install -y"
    export PACKAGE_CONF_DIR="/etc/apt/"
    export PACKAGE_CONF_FILE="apt.conf"
    export CA_UPDATER="update-ca-certificates"
    export extra_files="";
    ;;
centos)
    export SSL_CERT_DIR="/etc/ssl/certs/"
    export CA_CERT_DIR="/etc/pki/ca-trust/source/anchors/"
    export PACKAGE_MAN="yum"
    export INSTALL="$PACKAGE_MAN install -y"
    export PACKAGE_CONF_DIR="/etc/"
    export PACKAGE_CONF_FILE="yum.conf"
    export CA_UPDATER="update-ca-trust"
    export extra_files="";
    ;;
esac