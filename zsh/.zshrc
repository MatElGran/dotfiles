export EDITOR=nvim
export PAGER=most

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

# All function must have been loaded there
autoload -Uz compinit
compinit

RED='\033[1;31m'
NC='\033[0m'

if [ -d "/usr/local/opt/asdf" ]; then
  . /usr/local/opt/asdf/asdf.sh
else
  echo "${RED}Warning: brew prefix must have changed, asdf directory is not available${NC}"
  echo "${RED}Using fallback command${NC}"
  . $(brew --prefix asdf)/asdf.sh
fi

eval "$(direnv hook zsh)"
