#!/usr/bin/env bash
set -e

echo "\n ===========================================================
            ${magenta}Installing Server Configurations${NC}
 =========================================================== \n"

# Colors and visual Configurations
export magenta='\033[35m'
export red='\033[31m'
export NC='\033[0m'
export BLINK='\033[5m'
export NORMAL='\033[0'

echo "${magenta}Setting up SSH Installation...${NC}"

if [[ -d ${HOME}/.oh-my-zsh ]]; then
	read -p "Have you configured SSH? [Y/N] " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		# Generate a new SSH key
		ssh-keygen -t rsa 4096 -C "ahmad.a.assaf@gmail.com"
		# Add your key to the ssh-agent
		eval "$(ssh-agent -s)"
		ssh-add ~/.ssh/id_rsa

		# Add your SSH key to your account
		echo "${red}Please dont forget to add your id_rsa.pub key to Github${NC}"
	fi;
fi


if [[ -d ${HOME}/.oh-my-zsh ]]; then
	read -p "Can you confirm that you added the public key to Github? [Y/N] " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		install
	fi;
fi

function install() {
	echo "${magenta}Cloning Required repositories...${NC}"

	git clone -b linux "git@github.com:ahmadassaf/bash-it.git"
	git clone -b linux "git@github.com:ahmadassaf/dotfiles.git"

}


echo "${red}To configure SSH login without password please do that on your local machine: \n cat ~/.ssh/id_rsa.pub | ssh root@149.202.53.241 \"mkdir ~/.ssh; cat >> ~/.ssh/authorized_keys\"\n${NC}"
echo "${red}You also need to configure the git config file with: Host 149.202.53.241\nUser root\nIdentityFile ~/.ssh/id_rsa\nPubkeyAuthentication yes\nPreferredAuthentications publickey\n${NC}"