# /etc/bash.bashrc
#
# https://wiki.archlinux.org/index.php/Color_Bash_Prompt
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output. So make sure this doesn't display
# anything or bad things will happen !

# Test for an interactive shell. There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.

# If not running interactively, don't do anything!
[[ $- != *i* ]] && return



# Sensible Bash - An attempt at saner Bash defaults
# Maintainer: mrzool <http://mrzool.cc>
# Repository: https://github.com/mrzool/bash-sensible
# Version: 0.2.2

# Unique Bash version check
if ((BASH_VERSINFO[0] < 4))
then
  echo "sensible.bash: Looks like you're running an older version of Bash."
  echo "sensible.bash: You need at least bash-4.0 or some options will not work correctly."
  echo "sensible.bash: Keep your software up-to-date!"
fi

## GENERAL OPTIONS ##

# Prevent file overwrite on stdout redirection
# Use `>|` to force redirection to an existing file
set -o noclobber

# Update window size after every command
shopt -s checkwinsize

# Automatically trim long paths in the prompt (requires Bash 4.x)
PROMPT_DIRTRIM=2

# Enable history expansion with space
# E.g. typing !!<space> will replace the !! with your last command
bind Space:magic-space

# Turn on recursive globbing (enables ** to recurse all directories)
shopt -s globstar 2> /dev/null

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

## SMARTER TAB-COMPLETION (Readline bindings) ##

# Perform file completion in a case insensitive fashion
bind "set completion-ignore-case on"

# Treat hyphens and underscores as equivalent
bind "set completion-map-case on"

# Display matches for ambiguous patterns at first tab press
bind "set show-all-if-ambiguous on"

# Immediately add a trailing slash when autocompleting symlinks to directories
bind "set mark-symlinked-directories on"

## SANE HISTORY DEFAULTS ##

# Append to the history file, don't overwrite it
shopt -s histappend

# Save multi-line commands as one command
shopt -s cmdhist

# Record each line as it gets issued
PROMPT_COMMAND='history -a'

# Huge history. Doesn't appear to slow things down, so why not?
HISTSIZE=500000
HISTFILESIZE=10000000

# Avoid duplicate entries
HISTCONTROL="erasedups:ignoreboth"

# Don't record some commands
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"

# Use standard ISO 8601 timestamp
# %F equivalent to %Y-%m-%d
# %T equivalent to %H:%M:%S (24-hours format)
HISTTIMEFORMAT='%F %T '

# Enable incremental history search with up/down arrows (also Readline goodness)
# Learn more about this here: http://codeinthehole.com/writing/the-most-important-command-line-tip-incremental-history-searching-with-inputrc/
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\e[C": forward-char'
bind '"\e[D": backward-char'

## BETTER DIRECTORY NAVIGATION ##

# Prepend cd to directory names automatically
shopt -s autocd 2> /dev/null
# Correct spelling errors during tab-completion
shopt -s dirspell 2> /dev/null
# Correct spelling errors in arguments supplied to cd
shopt -s cdspell 2> /dev/null

# This defines where cd looks for targets
# Add the directories you want to have fast access to, separated by colon
# Ex: CDPATH=".:~:~/projects" will look for targets in the current working directory, in home and in the ~/projects folder
CDPATH="."

# This allows you to bookmark your favorite places across the file system
# Define a variable containing a path and you will be able to cd into it regardless of the directory you're in
shopt -s cdable_vars

# Examples:
# export dotfiles="$HOME/dotfiles"
# export projects="$HOME/projects"
# export documents="$HOME/Documents"
# export dropbox="$HOME/Dropbox"




function extract {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
 else
    if [ -f "$1" ] ; then
        NAME=${1%.*}
        #mkdir $NAME && cd $NAME
        case "$1" in
          *.tar.bz2)   tar xvjf ./"$1"    ;;
          *.tar.gz)    tar xvzf ./"$1"    ;;
          *.tar.xz)    tar xvJf ./"$1"    ;;
          *.lzma)      unlzma ./"$1"      ;;
          *.bz2)       bunzip2 ./"$1"     ;;
          *.rar)       unrar x -ad ./"$1" ;;
          *.gz)        gunzip ./"$1"      ;;
          *.tar)       tar xvf ./"$1"     ;;
          *.tbz2)      tar xvjf ./"$1"    ;;
          *.tgz)       tar xvzf ./"$1"    ;;
          *.zip)       unzip ./"$1"       ;;
          *.Z)         uncompress ./"$1"  ;;
          *.7z)        7z x ./"$1"        ;;
          *.xz)        unxz ./"$1"        ;;
          *.exe)       cabextract ./"$1"  ;;
          *)           echo "extract: '$1' - unknown archive method" ;;
        esac
    else
        echo "'$1' - file does not exist"
    fi
fi
}


export PS1="\u@\h \[$(tput sgr0)\]\[\033[38;5;81m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;11m\]\\$\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]"
export PS1="\[\033[38;5;170m\]\h\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;10m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]\n\[$(tput sgr0)\]\[\033[38;5;196m\]>>\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]"
export PS1="\[\033[38;5;170m\]\h\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;10m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]\n\[$(tput sgr0)\]\[\033[38;5;196m\]>>\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]"
export PS1="\[\033[38;5;201m\]\h\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;10m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]\n\[$(tput sgr0)\]"

KUBE_PS1_SYMBOL_ENABLE=false
source ~/.config/kube-ps1.sh
source ~/.config/git-prompt.sh

function color() {
  echo "$(tput setaf $1)"
}
function reset_color() {
  echo "$(tput sgr0)"
}

function last_status() {
    local last_status=$?
    local reset=$(reset_color)

    local failure="✖"
    local success=""

    if [[ "$last_status" != "0" ]]; then
	last_status="$(color 1)$failure$reset"
    else
	last_status="$(color 2)$success$reset"
    fi

    # ...some other things like hostname, current git branch etc

    echo "$last_status"
}


export PS1="\[\033[38;5;201m\]\h\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;10m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\] \$(last_status)\$(kube_ps1) \$(__git_ps1 '卜\[\033[38;5;10m\]%s') \n\[$(tput sgr0)\]"



eval `dircolors ~/.dircolors`

# Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion

# Prevent cd from listing non-directory files
complete -d cd


# Auto completions

for bcfile in ~/.bash_completion.d/* ; do
  [ -f "$bcfile" ] && . $bcfile
done

# source <(kubectl completion bash)
# source <(operator-sdk completion bash)
# source <(hugo gen autocomplete --completionfile=/dev/stdout | head -n -2)
# source '/home/ttauveron/lib/azure-cli/az.completion'
# source <(minikube completion bash)
# source <(kompose completion bash)
# source ~/.local/bin/aws_bash_completer
# source <(helm completion bash)
#complete -C terraform terraform
#. $HOME/.asdf/asdf.sh
#. $HOME/.asdf/completions/asdf.bash
# source <(argo completion bash)
# source <(argocd completion bash)
# source <(velero completion bash)


# Useful aliases
#alias kcn='kubectl config set-context $(kubectl config current-context) --namespace'
#alias kchcontext='kubectl config use-context '
alias "c=xclip -selection clipboard"
alias "v=xclip -o -selection clipboard"
alias ls='ls --color=auto'
alias l=ls
alias ll="ls -lArth"
alias rmacs="rm *\~"
alias cd..="cd .."


alias k="kubectl"
complete -F __start_kubectl k

### VPN helper
# vpn autocompletion
_vpn_complete()
{
  local cur prev
  COMPREPLY=()
  cur=${COMP_WORDS[COMP_CWORD]}
  prev=${COMP_WORDS[COMP_CWORD-1]}
  if [ $COMP_CWORD -eq 1 ]; then
    COMPREPLY=( $(compgen -W "connect disconnect killall" -- $cur) )
  elif [ $COMP_CWORD -eq 2 ]; then
    case "$prev" in
      "connect")
        COMPREPLY=( $(compgen -W "$(find ~/.vpn/ -name *.ovpn  -printf "%f\n")" -- $cur) )
        ;;
      "disconnect")
        COMPREPLY=( $(compgen -W "$(ls /tmp/openvpn_pids 2> /dev/null)" -- $cur) )
        ;;
      *)
        ;;
    esac
  fi
  return 0
}
complete -F _vpn_complete vpn
# vpn helper script
vpn() {
    ovpn_pid_dir=/tmp/openvpn_pids
    ovpn_filename=$2
    ovpn_pid_file=$ovpn_pid_dir/$2
    mkdir -p $ovpn_pid_dir
    if [ "$1" == "connect" ] && [ -f ~/.vpn/$ovpn_filename ]; then
	sudo openvpn --config ~/.vpn/$ovpn_filename --daemon --writepid $ovpn_pid_file
    elif [ "$1" == "disconnect" ] && [ -f $ovpn_pid_file ]; then
        sudo kill $(cat $ovpn_pid_file) && sudo rm $ovpn_pid_file
    elif [ "$1" == "killall" ]; then
        sudo killall openvpn 2> /dev/null && sudo rm $ovpn_pid_dir/*
    else
	echo "Usage : $ vpn [connect|disconnect] ovpn_file"
	return 1
    fi
}


# yq in docker
yq() {
    docker run --rm -i -v "${PWD}":/workdir mikefarah/yq "$@"
}

# Exports
export ALTERNATE_EDITOR=""
export EDITOR="vim"
export KUBE_EDITOR="vim"
#export EDITOR="emacsclient -t"                  # $EDITOR opens in terminal
#export VISUAL="emacsclient -c -a emacs"         # $VISUAL opens in GUI mode
export VISUAL="vim"         # $VISUAL opens in GUI mode

#export PATH=$PATH:/home/ttauveron/bin
export PATH=$PATH:~/.local/bin

# HSTR configuration - add this to ~/.bashrc
alias hh=hstr                    # hh to be alias for hstr
export HSTR_CONFIG=hicolor,raw-history-view,blacklist,substring-matching

# ensure synchronization between Bash memory and history file
export PROMPT_COMMAND="history -a; history -n; ${PROMPT_COMMAND}"
# if this is interactive shell, then bind hstr to Ctrl-r (for Vi mode check doc)
if [[ $- =~ .*i.* ]]; then bind '"\C-r": "\C-a hstr -- \C-j"'; fi
# if this is interactive shell, then bind 'kill last command' to Ctrl-x k
if [[ $- =~ .*i.* ]]; then bind '"\C-xk": "\C-a hstr -k \C-j"'; fi




# Disable flow-control to enable ctrl+s
stty -ixon
