#!/usr/bin/env bash

echo "Installing Xcode Command Line Tools for git and homebrew"
xcode-select --install

# wait until the command line tools are installed
echo "Waiting for Command Line Tools to install..."
while softwareupdate --list | grep -q "Command Line Tools"; do
    sleep 5
done

echo "
-------------------
"

echo "Installing homebrew..."
/bin/bash -c "$(curl https://raw.githubusercontent.com/Peter-512/.dotfiles/main/brew.sh)"


echo "
-------------------
"
echo "Setting up the ssh key..."
/bin/bash -c "$(curl https://raw.githubusercontent.com/Peter-512/.dotfiles/main/ssh-key.sh)"

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

echo "Installing oh-my-zsh..."
~/.dotfiles/oh-my-zsh.sh

echo "
-------------------
"

echo raycast://extensions/raycast/raycast/import-settings-data | pbcopy
echo "Raycast command has been copied into your clipboard. Paste it into Raycast and select 'Open in Browser' to run. Then select the .rayconfig file in the repo to import the settings."
