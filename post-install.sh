#!/usr/bin/env bash
set -e

# Colors and visual Configurations
export magenta='\e[0;35m'
export red='\e[0;31m'
export NC='\e[0m'

printf "${magenta}Installing recommended softwares...\n${NC}"

sudo apt-get update

sudo apt-get install build-essential

sudo apt-get install lamp-server^
sudo apt-get install nodejs
sudo apt-get install npm
sudo apt-get install default-jre
sudo apt-get install default-jdk
wget -q -O - https://jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get install jenkins
sudo add-apt-repository ppa:juju/stable
sudo apt-get update
sudo apt-get install juju-quickstart


curl https://raw.githubusercontent.com/creationix/nvm/v0.16.1/install.sh | sh

bash "~/.npm_globals.sh"
