#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

CODE_DIR="${HOME}/Code"
DOTFILE_DIR="${CODE_DIR}/dotfiles"

echo "Creating Code directory"
mkdir -p "${CODE_DIR}"

echo "Installing homebrew"
/usr/bin/env ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "Cloning dotfiles"
git clone git@github.com:matelgran/dotfiles.git "${DOTFILE_DIR}"

echo "brew installing stuff"
brew bundle --file "${DOTFILE_DIR}/Brewfile"

echo "Symlinking dotfiles"
stow -d "${DOTFILE_DIR}" -t ${HOME} zsh
stow -d "${DOTFILE_DIR}" -t ${HOME} nvim
stow -d "${DOTFILE_DIR}" -t ${HOME} git
