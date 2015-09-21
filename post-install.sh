#!/usr/bin/env bash
set -e

# Colors and visual Configurations
export magenta='\e[0;35m'
export red='\e[0;31m'
export NC='\e[0m'

printf "${magenta}Installing recommended softwares...\n${NC}"

# Adding MongoDB keys
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list
# Adding Jenkins keys
wget -q -O - https://jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'

sudo apt-get update

sudo apt-get install build-essential

sudo apt-get install lamp-server^
sudo apt-get install nodejs
sudo apt-get install npm
sudo apt-get install default-jre
sudo apt-get install default-jdk
sudo apt-get update
sudo apt-get install jenkins
sudo add-apt-repository ppa:juju/stable
sudo apt-get update
sudo apt-get install juju-quickstart


curl https://raw.githubusercontent.com/creationix/nvm/v0.16.1/install.sh | sh

# MongoDB
sudo apt-get update
sudo apt-get install -y mongodb-org

# Fix the node.js and node issue in Ubuntu
ln -s /usr/bin/nodejs /bin/node

# Install NPM globals
sudo bash "/root/.npm_globals.sh"
