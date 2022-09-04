#!/usr/bin/env bash

if [[ "$OSTYPE" != "darwin"* ]]; then
  echo "Aborted. The dotfiles is only for macOS"
  exit 1
fi

cd "$(dirname "${BASH_SOURCE[0]}")/.."

DOTFILES_ROOT=$(pwd)
DOTFILES_LOCAL_ROOT="$DOTFILES_ROOT/../dotfiles-local"

# Zsh
ln -sf $DOTFILES_ROOT/.zshrc $HOME/.zshrc

# Git
ln -sf $DOTFILES_ROOT/.gitignore_global $HOME/.gitignore
ln -sf $DOTFILES_ROOT/.gitconfig $HOME/.gitconfig

# Polipo
ln -sf $DOTFILES_ROOT/.polipo ~/.polipo

# PostgreSQL
ln -sf $DOTFILES_ROOT/.psqlrc $HOME/.psqlrc

# Install dotfiles-local
if [ -d "$DOTFILES_LOCAL_ROOT" ]; then
  cd $DOTFILES_LOCAL_ROOT
  $PWD/bin/install.sh
fi
