#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

CODE_DIR="${HOME}/Code"
DOTFILES_DIR="${CODE_DIR}/dotfiles"

echo "Creating Code directory"
mkdir -p "${CODE_DIR}"

echo "Installing homebrew"
/usr/bin/env ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "Cloning dotfiles"
git clone git@github.com:matelgran/dotfiles.git "${DOTFILES_DIR}"

echo "brew installing stuff"
brew bundle --file "${DOTFILES_DIR}/Brewfile"

echo "Symlinking dotfiles"
stow -d "${DOTFILES_DIR}" -t ${HOME} zsh
stow -d "${DOTFILES_DIR}" -t ${HOME} nvim
stow -d "${DOTFILES_DIR}" -t ${HOME} git
stow -d "${DOTFILES_DIR}" -t ${HOME} iterm
