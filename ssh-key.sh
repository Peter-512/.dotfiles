#!/usr/bin/env bash

# check for length of arguments
if [ $# -eq 0 ]; then
    echo "Please provide your email address as an argument."
    exit 1
fi

curl https://raw.githubusercontent.com/driesvints/dotfiles/HEAD/ssh.sh | sh -s "$1"

# copy the key to clipboard
pbcopy < ~/.ssh/id_ed25519.pub

# wait for user to copy the key
read -p "Paste the key (already copied into your clipboard) into your GitHub account and press enter to continue with the installation..."
