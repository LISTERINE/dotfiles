#!/usr/bin/python

# Determine platform
# This imports sys.stdout.write and uses it to output the OS name as returned by
# pythons platform.dist() function
from platform import dist
from cookiecutter.main import cookiecutter

os = dist()[0].lower()

systems = {"debian":
              {"SSL_CERT_DIR":"/etc/ssl/certs/",
               "CA_CERT_DIR":"/usr/local/share/ca-certificates",
               "PACKAGE_MAN":"apt-get",
               "PACKAGE_CONF_DIR":"/etc/apt/",
               "PACKAGE_CONF_FILE":"apt.conf",
               "CA_UPDATER":"update-ca-certificates",
               "extra_files":""
              },
           "ubuntu":
              {"SSL_CERT_DIR":"/etc/ssl/certs/",
               "CA_CERT_DIR":"/usr/local/share/ca-certificates",
               "PACKAGE_MAN":"apt-get",
               "PACKAGE_CONF_DIR":"/etc/apt/",
               "PACKAGE_CONF_FILE":"apt.conf",
               "CA_UPDATER":"update-ca-certificates",
               "extra_files":""
              },
           "centos":
              {"SSL_CERT_DIR":"/etc/ssl/certs/",
               "CA_CERT_DIR":"/etc/pki/ca-trust/source/anchors/",
               "PACKAGE_MAN":"yum",
               "PACKAGE_CONF_DIR":"/etc/",
               "PACKAGE_CONF_FILE":"yum.conf",
               "CA_UPDATER":"update-ca-trust",
               "extra_files":""
              }
}

cookiecutter('dotfiles/', extra_content=systems.get(os, {}))