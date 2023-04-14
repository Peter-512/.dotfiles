#!/usr/bin/env bash

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Downloading antigen zsh plugin manager"
curl -L git.io/antigen > ~/antigen.zsh
