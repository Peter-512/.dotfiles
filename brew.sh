#!/usr/bin/env bash

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

curl https://raw.githubusercontent.com/Peter-512/.dotfiles/main/Brewfile > ~/Brewfile

# Pass the Brewfile location
brew bundle --file ~/Brewfile
