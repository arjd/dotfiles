# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# brew general installs (sbin), gnu-time, coreutils, curl, openssl, pipx, fzf, go binaries
# NOTE: this is _much_ faster than `brew --prefix`
brewprefix=$(dirname $(which brew))/opt
export GOPATH=$HOME/go
export GOROOT=/usr/local/opt/go/libexec
export PATH="/usr/local/opt/gnu-time/libexec/gnubin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="$brewprefix/coreutils/bin:$PATH"
export PATH="$brewprefix/curl-openssl/bin:$PATH"
export PATH="$brewprefix/fzf:$PATH"
export PATH="$PATH:/Users/dornford/.local/bin"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH=$PATH:$GOPATH/bin:$GOROOT/bin

# gcloud
source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc

# zoxide, i.e. a more intuitive cd command
eval "$(zoxide init zsh)"

# zsh-specific settings
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(gitfast git-extras tmux aws common-aliases zsh-syntax-highlighting sandboxd)
source $ZSH/oh-my-zsh.sh

# powerlevel9k settings
POWERLEVEL9K_IGNORE_TERM_COLORS=true

# tmux plugin settings
ZSH_TMUX_FIXTERM=tru

# load computer-specific extras
# use ~/.zshenv for environment-specific settings
source ~/.extras 2>/dev/null

# load aliases and functions
source ~/.functions 2>/dev/null
source ~/.aliases 2>/dev/null

# use coreutils `ls` if possible…
hash gls >/dev/null 2>&1 || alias gls="ls"



#### stuff to do at start of new session  ####

# loading private key
if [ -f "${SSH_ENV}" ]; then
     . "${SSH_ENV}" > /dev/null
     ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi

# import pure styling for powerlevel10k
source ~/.oh-my-zsh/custom/themes/powerlevel10k/config/p10k-pure.zsh
