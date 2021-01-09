# set some important options (as early as possible)

# import new commands from the history file also in other zsh-session
setopt share_history

# save each command's beginning timestamp and the duration to the history file
setopt extended_history

# If a new command line being added to the history list duplicates an older
# one, the older command is removed from the list
setopt histignorealldups

# remove command lines from the history list when the first character on the
# line is a space
setopt histignorespace

# if a command is issued that can't be executed as a normal command, and the
# command is the name of a directory, perform the cd command to that directory.
setopt auto_cd

# in order to use #, ~ and ^ for filename generation grep word
# *~(*.gz|*.bz|*.bz2|*.zip|*.Z) -> searches for word not in compressed files
# don't forget to quote '^', '~' and '#'!
setopt extended_glob

# display PID when suspending processes as well
setopt longlistjobs

# report the status of backgrounds jobs immediately
setopt notify

# whenever a command completion is attempted, make sure the entire command path
# is hashed first.
setopt hash_list_all

# not just at the end
setopt completeinword

# Don't send SIGHUP to background processes when the shell exits.
setopt nohup

# make cd push the old directory onto the directory stack.
setopt auto_pushd

# avoid "beep"ing
setopt nobeep

# don't push the same dir twice.
setopt pushd_ignore_dups

# * shouldn't match dotfiles. ever.
setopt noglobdots

# use zsh style word splitting
setopt noshwordsplit

# automatically remove duplicates from these arrays
typeset -U path PATH cdpath CDPATH fpath FPATH manpath MANPATH

# Add brew-installed completion files to FPATH
if type brew &>/dev/null; then
  fpath=($(brew --prefix)/share/zsh/site-functions ${HOME}/.zfunc $fpath)
fi

# All function must have been loaded there
autoload -Uz compinit
compinit

# Hooks
. $(brew --prefix)/opt/asdf/asdf.sh
eval "$(direnv hook zsh)"

# ENV
export EDITOR=nvim
export PAGER=bat
export BAT_PAGER="less -RF"

export PATH="${HOME}/.cargo/bin:${HOME}/.local/bin:/usr/local/opt/libpq/bin:$PATH"

export MAIN_RUBY_HOME="${HOME}/.asdf/installs/ruby/2.7.1"
export MAIN_NODEJS_HOME="${HOME}/.asdf/installs/nodejs/14.2.0"
export MAIN_PYTHON2_HOME="${HOME}/.asdf/installs/python/2.7.18"
export MAIN_PYTHON3_HOME="${HOME}/.asdf/installs/python/3.8.3"

# Aliases
alias ez='nvim "${HOME}/.zshrc"'
alias sz='source "${HOME}/.zshrc"'

alias dcup="docker-compose up -d"
alias dcdn="docker-compose down"

alias ls="ls -G"

alias ovs="overmind start -c release"
alias ovc="overmind connect"
alias ovk="overmind kill"
alias ovr="overmind restart"

alias amend="git commit --amend"
alias gck="git checkout"
alias gl="git log --oneline --decorate --all"
alias glg="git log --oneline --decorate --graph --all"
alias glh="git log --oneline --decorate"
alias glgh="git log --oneline --decorate --graph"
alias gss="git status"
alias gsh="git stash"
alias gup="git fetch -p && git pull --rebase"
alias gwip="git commit -m WIP"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source $(brew --prefix)/opt/antigen/share/antigen/antigen.zsh

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-history-substring-search

antigen apply

source /Users/mat/.config/broot/launcher/bash/br

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

update_hosts() {
  set -x
  if [[ -e hosts ]] then
    rm hosts
  fi
  wget -O hosts http://someonewhocares.org/hosts/hosts
  sudo mv /etc/hosts /etc/hosts.bak
  sudo mv hosts /etc/hosts
  set +x
}

eval "$(starship init zsh)"
