#!/usr/bin/env bash

# check for length of arguments
if [ $# -eq 0 ]; then
    echo "Please provide your email address as an argument..."
    exit 1
fi

echo "Installing Xcode Command Line Tools for git and homebrew"
xcode-select --install

echo "
-------------------
"

echo "Setting up the ssh key..."
/bin/bash -c $(curl https://raw.githubusercontent.com/Peter-512/.dotfiles/main/ssh-key.sh)
read -p "Waiting for you to paste the key into github..."

echo "
-------------------
"

echo "Cloning dotfiles repo..."
git clone git@github.com:Peter-512/.dotfiles.git ~/.dotfiles

echo "
-------------------
"

echo "Linking dotfiles..."
~/.dotfiles/link.sh

echo "
-------------------
"

# echo "Setting up macOS defaults..."
# ~/.dotfiles/set-defaults.sh

# echo "
# -------------------
# "

echo "Installing homebrew..."
~/.dotfiles/brew.sh

echo "
-------------------
"

echo "Installing oh-my-zsh..."
~/.dotfiles/oh-my-zsh.sh

echo "
-------------------
"

echo raycast://extensions/raycast/raycast/import-settings-data | pbcopy
echo "Raycast command has been copied into your clipboard. Paste it into Raycast and select 'Open in Browser' to run. Then select the .rayconfig file in the repo to import the settings."
