# standard exports
export EDITOR=nano
export SSH_ENV=$HOME/.ssh/environment

# computer-specific exports
if [ -f ~/.env ]; then
  source ~/.env
fi

# npm exports
export NVM_DIR=~/.nvm

# zsh exports
export ZSH=~/.oh-my-zsh
export GREP2AWK="^G^A"
