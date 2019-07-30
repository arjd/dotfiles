# standard exports
export EDITOR=nano
export SSH_ENV=$HOME/.ssh/environment

# computer-specific exports
if [ -f ~/.env ]; then
  source ~/.env
fi

# npm exports
export NVM_DIR="/Users/dornford/.nvm"

# zsh exports
export ZSH="/Users/dornford/.oh-my-zsh"
export GREP2AWK="^G^A"
