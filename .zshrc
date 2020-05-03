# see ~/.zshenv for environment-specific settings

# jenv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

# pass/gopass
alias pass=gopass

# nvm
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" --no-use

# homebrew
export PATH="/usr/local/sbin:$PATH"

# zsh-specific settings
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(gitfast git-extras aws common-aliases emoji nvm sudo tmux grep2awk zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh
source $(brew --prefix)/opt/git-extras/share/git-extras/git-extras-completion.zsh

# powerlevel9k settings
POWERLEVEL9K_IGNORE_TERM_COLORS=true

# tmux plugin settings
ZSH_TMUX_FIXTERM=true

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
#clear

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/local/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/local/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/usr/local/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/usr/local/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export PATH=/usr/local/anaconda3/bin:$PATH
