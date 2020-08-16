# see ~/.zshenv for environment-specific settings

# brew general installs, gnu-time, coreutils, curl, and openssl
brewprefix=$(dirname $(which brew))/opt
export PATH="/usr/local/opt/gnu-time/libexec/gnubin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="$brewprefix/coreutils/bin:$PATH"
export PATH="$brewprefix/curl-openssl/bin:$PATH"

# zsh-specific settings
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(gitfast git-extras tmux aws common-aliases zsh-syntax-highlighting sandboxd)
source $ZSH/oh-my-zsh.sh

# powerlevel9k settings
POWERLEVEL9K_IGNORE_TERM_COLORS=true

# tmux plugin settings
ZSH_TMUX_FIXTERM=tru

# computer-specific functions
if [ -f ~/.functions ]; then
  source ~/.functions
fi

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

# computer-specific aliases
if [ -f ~/.aliases ]; then
    source ~/.aliases
fi

# pass/gopass
alias pass=gopass

# productivity aliases 
alias ls='ls -lah'


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

