#!/usr/bin/env bash
# Symlink every file/dir in ~/.dotfiles/files/ into $HOME, preserving nested
# paths. ~/.config/nvim becomes a symlink to ~/.dotfiles/files/.config/nvim
# (we link the leaf dir, not the whole ~/.config).

set -euo pipefail

SRC="$HOME/.dotfiles/files"

link() {
    local target="$1"       # path under SRC
    local dest="$HOME/${target#$SRC/}"

    mkdir -p "$(dirname "$dest")"

    if [ -L "$dest" ] || [ -e "$dest" ]; then
        rm -rf "$dest"
    fi
    ln -s "$target" "$dest"
    echo "linked $dest -> $target"
}

# Top-level files and dirs (except .config, which we descend into one level)
for entry in "$SRC"/.* "$SRC"/*; do
    name=$(basename "$entry")
    case "$name" in
        .|..|.DS_Store) continue ;;
    esac
    [ -e "$entry" ] || continue

    if [ "$name" = ".config" ]; then
        # Symlink each direct child of .config (nvim, kitty, ...) individually
        for sub in "$entry"/*; do
            [ -e "$sub" ] || continue
            link "$sub"
        done
    else
        link "$entry"
    fi
done
