#!/usr/bin/env bash

mkdir ~/.ssh

curl https://raw.githubusercontent.com/Peter-512/.dotfiles/main/id_ed25519.pub > ~/.ssh/id_ed25519.pub
ansible-vault decrypt ~/.ssh/id_ed25519.pub

curl https://raw.githubusercontent.com/Peter-512/.dotfiles/main/id_ed25519 > ~/.ssh/id_ed25519
ansible-vault decrypt ~/.ssh/id_ed25519

# Adding your SSH key to the ssh-agent
# https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#adding-your-ssh-key-to-the-ssh-agent
eval "$(ssh-agent -s)"

touch ~/.ssh/config
printf "Host *\n AddKeysToAgent yes\n UseKeychain yes\n IdentityFile ~/.ssh/id_ed25519" > ~/.ssh/config

ssh-add -K ~/.ssh/id_ed25519
