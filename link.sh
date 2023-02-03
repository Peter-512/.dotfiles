#!/usr/bin/env bash

# go through all files in the files folder
for file in ~/.dotfiles/files/*; do
    # get the filename
    filename=$(basename "$file")

    # check if the file is a symlink
    if [ -L "$HOME/$filename" ]; then
        # if it is, remove it
        rm "$HOME/$filename"
    fi

    # create a symlink
    ln -s "$file" "$HOME/$filename"
done