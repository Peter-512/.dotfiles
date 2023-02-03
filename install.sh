#!/usr/bin/env bash

# check for length of arguments
if [ $# -eq 0 ]; then
    echo "Please provide your email address as an argument..."
    exit 1
fi

echo "Installing Xcode Command Line Tools for git and homebrew"
xcode-select --install

echo "Setting up the ssh key..."
./ssh-key.sh "$1"

echo "Cloning dotfiles repo..."
git clone git@github.com:Peter-512/.dotfiles.git ~/.dotfiles

echo "Linking dotfiles..."
./link.sh

echo "Setting up macOS defaults..."
./set-defaults.sh

echo "Installing homebrew..."
./brew.sh

echo "Installing oh-my-zsh..."
./oh-my-zsh.sh

echo raycast://extensions/raycast/raycast/import-settings-data | pbcopy
echo "Raycast command has been copied into your clipboard. Paste it into Raycast and select 'Open in Browser' to run. Then select the .rayconfig file in the repo to import the settings."