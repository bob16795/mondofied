#!/bin/bash
#  _               _
# | |__   __ _ ___| |__  _ __ ___
# | '_ \ / _` / __| '_ \| '__/ __|
# | |_) | (_| \__ \ | | | | | (__
# |_.__/ \__,_|___/_| |_|_|  \___|

stty -ixon # Disable ctrl-s and ctrl-q.
shopt -s autocd #Allows you to cd into directory merely by typing the directory name.
HISTSIZE= HISTFILESIZE= # Infinite history.
#wal -Rqe
# Setting Bash prompt. Capitalizes username and host if root user (my root user uses this same config file).
if [ "$EUID" -ne 0 ]
	then export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"
	else export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]ROOT\[$(tput setaf 2)\]@\[$(tput setaf 4)\]$(hostname | awk '{print toupper($0)}') \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"
fi
export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"
LANG=en_US.UTF-8
LANGUAGE=en_US:en
LC_CTYPE="en_US.UTF-8"
#if [ "$(tty)" == "/dev/tty1" ]
source ~/.profile
#fi

#[ -z "$TMUX"  ] && { tmux attach -tStarTmux || tmux_a && exit;}
#[ -z "$TMUX"  ] && { tmux attach || exec tmux new-session && exit;}
export GPG_TTY=$(tty)

# System Maintainence
alias sdn="sudo shutdown now"
alias psref="gpg-connect-agent RELOADAGENT /bye" # Refresh gpg

# Some aliases
alias e="$EDITOR"
alias p="sudo pacman"
alias SS="sudo systemctl"
alias v="vim"
alias sv="sudo vim"
alias r="ranger"
alias sr="sudo ranger"
alias ka="killall"
alias g="git":
alias trem="transmission-remote"
alias mkd="mkdir -pv"
alias ref="shortcuts && source ~/.bashrc" # Refresh shortcuts manually and reload bashrc
alias bw="wal -i ~/.config/wall.png" # Rerun pywal

# Adding color
alias ls='ls -hN --color=auto --group-directories-first'
alias grep="grep --color=auto"
alias diff="diff --color=auto"
alias ccat="highlight --out-format=ansi" # Color cat - print file with syntax highlighting.

# Internet
alias yt="youtube-dl --add-metadata -ic" # Download video link
alias yta="yt -x -f bestaudio/best" # Download only audio
alias YT="youtube-viewer"
alias playvid="mplayer -vo fbdev2 -vf scale=665:384 -geometry 724:0 -ao pulse"
shdl() { curl -O $(curl -s http://sci-hub.tw/"$@" | grep location.href | grep -o http.*pdf) ;}
vf() { $EDITOR $(fzf) ;}
#pdf() { groff -T pdf -t -ms $@ > $@i.pdf; zathura $@.pdf &; }
export TERMINAL=alacritty
export PATH=$PATH:~/.local/bin/:~/bin:~/.gem/ruby/2.5.0/bin
export PATH="/home/john/cod/Ndless/ndless-sdk/toolchain/install/bin:/home/john/cod/Ndless/ndless-sdk/bin:${PATH}"
#~/.cache/wal/colors.sh
#neofetch
#source ~/.dotfiles/index.shp

#tmuxinator start main
