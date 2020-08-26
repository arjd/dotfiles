# see ~/.zshenv for environment-specific settings

# brew general installs, gnu-time, coreutils, curl, openssl, pipx
brewprefix=$(dirname $(which brew))/opt
export PATH="/usr/local/opt/gnu-time/libexec/gnubin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="$brewprefix/coreutils/bin:$PATH"
export PATH="$brewprefix/curl-openssl/bin:$PATH"
export PATH="$PATH:/Users/dornford/.local/bin"
# export GOPATH=$HOME/go
# export GOROOT=/usr/local/opt/go/libexec
# export NODE_PATH=`which node`
# export LATEX_PATH=/Library/TeX/texbin
# export DOTNET_PATH=/usr/local/share/dotnet:~/.dotnet/tools
# export PATH=$NODE_PATH:$PATH:$GOPATH/bin:$GOROOT/bin

# zsh-specific settings
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(gitfast git-extras tmux aws common-aliases zsh-syntax-highlighting sandboxd)
source $ZSH/oh-my-zsh.sh

# powerlevel9k settings
POWERLEVEL9K_IGNORE_TERM_COLORS=true

# tmux plugin settings
ZSH_TMUX_FIXTERM=tru

# computer-specific extras, plus aliases and functions
source ~/.extras 2>/dev/null
source ~/.functions 2>/dev/null
source ~/.aliases 2>/dev/null

# functions
function f() { # recursively find path by name
    find . -iname "*$1*" ${@:2}
}
function r() { # recursively grep through files
    grep "$1" ${@:2} -R .
}
function mkcd() { # make new dir and cd into it
    mkdir -p "$@" && cd "$_";
}
function start_agent { # loads private key into every new session
    echo "Initializing new SSH agent..."
    # spawn ssh-agent
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add
}

# pass/gopass
alias pass=gopass

# productivity aliases 
alias ll='ls -lhATF'

# get file permissions in octal (i.e. 0755)
alias perms="stat -f '%A %a %N' *"

# dotfiles bare repo
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"

# Easier navigation: .., ..., ~ and -
alias ..="cd .."
alias cd..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~" # `cd` is probably faster to type though
alias -- -="cd -"

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
