# Profiling
# zmodload zsh/zprof
# zmodload zsh/datetime
# setopt PROMPT_SUBST
# PS4='+$EPOCHREALTIME %N:%i> '

# logfile=$(mktemp zsh_profile.XXXXXXXX)
# echo "Logging to $logfile"
# exec 3>&2 2>$logfile

# setopt XTRACE

# shell options
setopt +o cshnullglob

# Force compinit to run once daily instead of on shell launch
autoload -Uz compinit
ZSH_DISABLE_COMPFIX="true"
ZSH_COMPDUMP=~/.zshcompdump
# ls $ZSH_COMPDUMP(.mh+24N)
# if [[ $? -eq 1 ]]; then
#   echo "true"
# 	compinit -d $ZSH_COMPDUMP;
# else
#   echo "false"
# 	compinit -C;
# fi;

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Brewfile
export HOMEBREW_BREWFILE=~/.brewfile

# brew general installs (sbin), gnu-time, coreutils, curl, openssl, pipx, fzf, go binaries, squashfuse, java
eval $(/opt/homebrew/bin/brew shellenv)
brewprefix=$(dirname $(dirname $(which brew)))
export GOPATH=$HOME/go
export GOROOT=$brewprefix/opt/go/libexec
export PATH="$brewprefix/opt/gnu-time/libexec/gnubin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="$brewprefix/coreutils/bin:$PATH"
export PATH="$brewprefix/openssl/bin:$PATH"
export PATH="$brewprefix/fzf:$PATH"
export PATH="$PATH:/Users/dornford/.local/bin"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH=$PATH:$GOPATH/bin:$GOROOT/bin
export PATH="$PATH:$brewprefix/Cellar/squashfuse/0.1.104/bin"
export PATH="$PATH:$brewprefix/openjdk/bin"

# oh-my-zsh theme, plugin, and load
source $ZSH/oh-my-zsh.sh
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(gitfast git-extras tmux aws common-aliases zsh-syntax-highlighting autoupdate sandboxd)

# gcloud
source $brewprefix/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
source $brewprefix/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc

# zoxide, i.e. a more intuitive cd command
eval "$(zoxide init zsh)"

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

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

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
source $(brew --prefix)/opt/powerlevel10k/powerlevel10k.zsh-theme

# Profiling
# unsetopt XTRACE
# exec 2>&3 3>&-
# zprof

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
