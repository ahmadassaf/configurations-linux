#!/usr/bin/env bash
set -e

printf "\n ===========================================================
            ${magenta}Installing Server Configurations${NC}
 =========================================================== \n"

# Colors and visual Configurations
export magenta='\e[0;35m'
export red='\e[0;31m'
export NC='\e[0m'

# Find the location of the script, this brings out the location of the current directory
export SCRIPT_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# The source directory and target directories.
export SOURCE_LOCATION="$SCRIPT_DIRECTORY" # Contains the files and directories I want to work with.

printf "${magenta}Setting up SSH Installation...\n${NC}"

read -p "Have you configured SSH? [Y/N] " -n 1;
echo "";
if [[ $REPLY =~ ^[Nn]$ ]]; then
	# Generate a new SSH key
	ssh-keygen -t rsa -b 4096 -C "ahmad.a.assaf@gmail.com"
	# Add your key to the ssh-agent
	eval "$(ssh-agent -s)"
	ssh-add ~/.ssh/id_rsa

	# Add your SSH key to your account
	printf "${red}Please dont forget to add your id_rsa.pub key to Github${NC}"
fi;


read -p "Can you confirm that you added the public key to Github? [Y/N] " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then

	printf "${magenta}Cloning Required repositories...${NC}"

	if [ -e "$HOME/.bash_it" ]; then
		git clone -b linux "git@github.com:ahmadassaf/bash-it.git"
	fi

	if [ -e "$HOME/.dotfiles" ]; then
		git clone -b linux "git@github.com:ahmadassaf/dotfiles.git"
	fi

	ln -s "$SOURCE_LOCATION/bash-it" "${HOME}/.bash_it"
	# run the bash-it install script
	bash "${HOME}/.bash_it/install.sh"

fi;


printf "${red}To configure SSH login without password please do that on your local machine:\ncat ~/.ssh/id_rsa.pub | ssh root@149.202.53.241 \"mkdir ~/.ssh; cat >> ~/.ssh/authorized_keys\"\n\n${NC}"
printf "${red}You also need to configure the git config file with: Host 149.202.53.241\nUser root\nIdentityFile ~/.ssh/id_rsa\nPubkeyAuthentication yes\nPreferredAuthentications publickey\n${NC}"