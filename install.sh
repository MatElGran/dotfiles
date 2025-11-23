#!/bin/bash

# TODO header,

abort () {
  printf "%s\n" "$@" >&2
  exit 1
}

if [[ ! -x $(type -P curl) ]]; then
  abort "This script needs curl to run"
fi

OS="$(uname)"
ARCH="$(uname -m)"
if [[ "${OS}" != "Darwin" ]] || [[ "${ARCH}" != "arm64" ]]; then 
  abort "This has only been tested with macOS on arm64 architecture"
fi

DOTFILES_REPO="${DOTFILES_REPO:-"https://github.com/MatElGran/dotfiles.git"}"
DOTFILES_DIR=${DOTFILES_DIR:-${HOME}/code/dotfiles}
if [[ -d "$DOTFILES_DIR" ]] && [[ -n $(ls -A "$DOTFILES_DIR") ]]; then
  abort "$DOTFILES_DIR exists and is not empty"
fi

echo "This will install Homebrew, git, then clone $DOTFILES_REPO to $DOTFILES_DIR"
# Install Homebrew
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Activate homebrew

eval "$(/opt/homebrew/bin/brew shellenv)"

# Install git and stow
brew install git 
brew install stow 

mkdir -p "$DOTFILES_DIR"
git clone "$DOTFILES_REPO" "$DOTFILES_DIR"

stow --dotfiles --no-folding --dir="$DOTFILES_DIR" --target="$HOME" zsh
