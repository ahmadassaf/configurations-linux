#!/usr/bin/env bash
set -e

printf "Setting up SSH Installation...\n"

read -p "Have you configured SSH? [Y/N] " -n 1;
echo "";
if [[ $REPLY =~ ^[Nn]$ ]]; then
	# Generate a new SSH key
	echo "Please enter ${red}your email address: " && read
	echo "";
	ssh-keygen -t rsa -b 4096 -C "$line"
	# Add your key to the ssh-agent
	eval "$(ssh-agent -s)"
	ssh-add ~/.ssh/id_rsa

	# Add your SSH key to your account
    echo "";
    cat ~/.ssh/id_rsa.pub
    echo "";

	printf "Please dont forget to add your id_rsa.pub key [above] to Github before you continue"
fi;