export EDITOR=nvim
export PAGER=most

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

# All function must have been loaded there
autoload -Uz compinit
compinit

. $(brew --prefix)/opt/asdf/asdf.sh


eval "$(direnv hook zsh)"
