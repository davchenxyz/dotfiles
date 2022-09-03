#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")/.."

DOTFILES_ROOT=$(pwd)

echo $DOTFILES_ROOT

# Git
ln -sf $DOTFILES_ROOT/.gitignore $HOME/.gitignore
ln -sf $DOTFILES_ROOT/.gitconfig $HOME/.gitconfig
