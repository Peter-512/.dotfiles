#!/usr/bin/env bash

# Install Homebrew
if test ! "$(which brew)"; then
  echo "Installing homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Homebrew is already installed"
fi
# Alternate, more verbose way to installs homebrew
#/bin/bash -c "$(curl https://gist.githubusercontent.com/m1yag1/bb0ffef90bbc40f313844ec92427ac95/raw/1999f9248124edd41070ddc17448ed99dcba9b58/brew_install.sh)"

#curl https://raw.githubusercontent.com/Peter-512/.dotfiles/main/Brewfile > ~/Brewfile # Figure out a way to detect if run from curl or from local file

# necessary?
#sudo chown -R "$(whoami)" /usr/local/var/homebrew

# Pass the Brewfile location
brew bundle --file ~/.dotfiles/Brewfile
