#!/usr/bin/env bash
set -e

printf "${magenta}Installing apache modules and configurations...\n${NC}"

# Installing pagespeed module
wget https://dl-ssl.google.com/dl/linux/direct/mod-pagespeed-stable_current_amd64.deb
sudo dpkg -i mod-pagespeed-*.deb
sudo apt-get -f install
sudo service apache2 reload

# installing security modules
sudo apt-get install libapache2-modsecurity

#installing Spamhaus
sudo apt-get install libapache2-mod-spamhaus

# Enabling some vital Apache Modules
sudo a2enmod rewrite
sudo a2enmod headers
sudo a2enmod mod-security
sudo a2enmod mod-spamhaus

printf "${magenta}Visit this page: https://www.digitalocean.com/community/tutorials/how-to-install-configure-and-use-modules-in-the-apache-web-server for installation instructions and modifications\n${NC}"