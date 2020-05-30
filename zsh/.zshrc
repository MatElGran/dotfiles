
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

# All function must have been loaded there
autoload -Uz compinit
compinit

. $(brew --prefix)/opt/asdf/asdf.sh
eval "$(direnv hook zsh)"

export EDITOR=nvim
export PAGER=most
export BAT_PAGER="less -RF"

export MAIN_RUBY_HOME="${HOME}/.asdf/installs/ruby/2.7.1"
export MAIN_NODEJS_HOME="${HOME}/.asdf/installs/nodejs/14.2.0"
export MAIN_PYTHON2_HOME="${HOME}/.asdf/installs/python/2.7.18"
export MAIN_PYTHON3_HOME="${HOME}/.asdf/installs/python/3.8.3"
