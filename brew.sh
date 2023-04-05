#!/usr/bin/env bash

whoami

# Install Homebrew
#/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
/bin/bash -c "$(curl https://gist.githubusercontent.com/m1yag1/bb0ffef90bbc40f313844ec92427ac95/raw/1999f9248124edd41070ddc17448ed99dcba9b58/brew_install.sh)"

curl https://raw.githubusercontent.com/Peter-512/.dotfiles/main/Brewfile > ~/Brewfile

# Pass the Brewfile location
brew bundle --file ~/Brewfile
