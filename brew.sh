#!/usr/bin/env bash

# Install Homebrew
/bin/bash - c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Pass the Brewfile location
brew bundle --file ~/.dotfiles/Brewfile
