#!/usr/bin/env bash

# check for length of arguments
if [ $# -eq 0 ]; then
    echo "Please provide your email address as an argument."
    exit 1
fi

# Generating a new SSH key
# https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#generating-a-new-ssh-key
ssh-keygen -t ed25519 -C "$1" -f ~/.ssh/id_ed25519

# Adding your SSH key to the ssh-agent
# https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#adding-your-ssh-key-to-the-ssh-agent
eval "$(ssh-agent -s)"

touch ~/.ssh/config
echo "Host *\n AddKeysToAgent yes\n UseKeychain yes\n IdentityFile ~/.ssh/id_ed25519" | tee ~/.ssh/config

ssh-add -K ~/.ssh/id_ed25519

# copy the key to clipboard
pbcopy < ~/.ssh/id_ed25519.pub

# wait for user to copy the key
read -p "Paste the key (already copied into your clipboard) into your GitHub account and press enter to continue with the installation..."
