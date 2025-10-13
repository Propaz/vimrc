#!/bin/bash

# This script sets up the Vim configuration.

# Define the vim config directory
VIM_DIR="$HOME/.vim"
VIMRC_SOURCE="$VIM_DIR/vimrc"
VIMRC_TARGET="$HOME/.vimrc"

# 1. Create necessary directories for backups, swap files, and undo history
echo "Creating Vim directories..."
mkdir -p "$VIM_DIR/.undo"
mkdir -p "$VIM_DIR/.backup"
mkdir -p "$VIM_DIR/.swp"

# 2. Download vim-plug if it doesn't exist
PLUG_VIM="$VIM_DIR/autoload/plug.vim"
if [ ! -f "$PLUG_VIM" ]; then
    echo "Downloading vim-plug..."
    curl -fLo "$PLUG_VIM" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
else
    echo "vim-plug already exists."
fi

# 3. Create a symbolic link from ~/.vim/vimrc to ~/.vimrc
# Check if the symlink exists and points to the correct source
if [ -L "$VIMRC_TARGET" ] && [ "$(readlink "$VIMRC_TARGET")" = "$VIMRC_SOURCE" ]; then
    echo "Symlink from $VIMRC_SOURCE to $VIMRC_TARGET already exists."
else
    echo "Creating symlink for .vimrc..."
    # Remove existing .vimrc if it's a file or a different symlink
    rm -f "$VIMRC_TARGET"
    ln -s "$VIMRC_SOURCE" "$VIMRC_TARGET"
fi

# 4. Install plugins using vim-plug
echo "Installing plugins... (This will open Vim)"
vim +PlugInstall +qall

echo "Setup complete!"
