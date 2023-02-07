#!/usr/bin/env bash

# check for length of arguments
if [ $# -eq 0 ]; then
    echo "Please provide your email address as an argument..."
    exit 1
fi

echo "Installing Xcode Command Line Tools for git and homebrew"
xcode-select --install

echo "Setting up the ssh key..."
curl https://raw.githubusercontent.com/Peter-512/.dotfiles/main/ssh-key.sh | sh -s "$1"

echo "Cloning dotfiles repo..."
git clone git@github.com:Peter-512/.dotfiles.git ~/.dotfiles

echo "Linking dotfiles..."
~/.dotfiles/link.sh

echo "Setting up macOS defaults..."
~/.dotfiles/set-defaults.sh

echo "Installing homebrew..."
~/.dotfiles/brew.sh

echo "Installing oh-my-zsh..."
~/.dotfiles/oh-my-zsh.sh

echo raycast://extensions/raycast/raycast/import-settings-data | pbcopy
echo "Raycast command has been copied into your clipboard. Paste it into Raycast and select 'Open in Browser' to run. Then select the .rayconfig file in the repo to import the settings."
