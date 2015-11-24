#!/bin/bash

# Akira Baruah's bash config
# References (and thanks!):
#  - Archlinux wiki
#  - Mitchell Hashimoto
#  - Ryan Tomayko

#-------------------------------------------------------------------------------
# Shell Options
#-------------------------------------------------------------------------------

# Basics
: ${HOME=~}
: ${LOGNAME=$(id -un)}
: ${UNAME=$(uname)}

# Resolve hostnames from this file
: ${HOSTFILE=~/.ssh/known_hosts}

# System bashrc
test -r /etc/bash.bashrc && source /etc/bash.bashrc

# Notify bg task completion immediately
set -o notify

# Default umask
umask 0077

#-------------------------------------------------------------------------------
# Path
#-------------------------------------------------------------------------------

# ~/bin if it exists
test -d "$HOME/bin" && PATH="$HOME/bin:$PATH"

#-------------------------------------------------------------------------------
# Env. Configuration
#-------------------------------------------------------------------------------

# detect interactive shell
case "$-" in
    *i*) INTERACTIVE=yes ;;
    *)   unset INTERACTIVE ;;
esac

# detect login shell
case "$0" in
    -*) LOGIN=yes ;;
    *)  unset LOGIN ;;
esac

# Proper locale
: ${LANG:="en_US.UTF-8"}
: ${LANGUAGE:="en"}
: ${LC_CTYPE:="en_US.UTF-8"}
: ${LC_ALL:="en_US.UTF-8"}
export LANG LANGUAGE LC_CTYPE LC_ALL

# Always use passive mode FTP
: ${FTP_PASSIVE:=1}
export FTP_PASSIVE

#-------------------------------------------------------------------------------
# Editor & Pager
#-------------------------------------------------------------------------------
EDITOR="emacs"
export EDITOR

PAGER="less -FirSwX"
MANPAGER="$PAGER"
export PAGER MANPAGER

#-------------------------------------------------------------------------------
# Prompt
#-------------------------------------------------------------------------------

# Regular Colors (from ArchWiki)
Black='\[\e[0;30m\]'      # Black
Red='\[\e[0;31m\]'        # Red
Green='\[\e[0;32m\]'      # Green
Yellow='\[\e[0;33m\]'     # Yellow
Blue='\[\e[0;34m\]'       # Blue
Purple='\[\e[0;35m\]'     # Purple
Cyan='\[\e[0;36m\]'       # Cyan
White='\[\e[0;37m\]'      # White

# Bold (from ArchWiki)
BBlack='\[\e[1;30m\]'     # Black
BRed='\[\e[1;31m\]'       # Red
BGreen='\[\e[1;32m\]'     # Green
BYellow='\[\e[1;33m\]'    # Yellow
BBlue='\[\e[1;34m\]'      # Blue
BPurple='\[\e[1;35m\]'    # Purple
BCyan='\[\e[1;36m\]'      # Cyan
BWhite='\[\e[1;37m\]'     # White

# Other
PS_CLEAR="\[\e[0m\]"      # Reset (normal)
Invis='\[\e[8m\]'         # Invisible
PS_END="\[\e[m\]"         # End coloring
SCREEN_ESC="\[\033k\033\134\]"

COLOR1="${BYellow}"
COLOR2="${Yellow}"
P="\$"

prompt_color() {
    unset PROMPT_COMMAND
    PS1="${COLOR2}\h ${PS_CLEAR}[${COLOR2}\W${PS_CLEAR}] "
    PS1+="${COLOR1}${P}${PS_CLEAR}${PS_END} "
    PS2="${Invis}\h [\W]${PS_CLEAR} ${COLOR1}>${PS_CLEAR}${PS_END} "
    export PS1 PS2
}

#-------------------------------------------------------------------------------
# Aliases / Functions
#-------------------------------------------------------------------------------
test -f .bash_aliases && source .bash_aliases

# Usage: puniq [path]
# Remove duplicate entries from a PATH style value while
# retaining the original order.
puniq() {
    echo "$1" | tr : '\n' | nl | sort -u -k 2,2 | sort -n |
    cut -f 2- | tr '\n' : | sed -e 's/:$//' -e 's/^://'
}

#-------------------------------------------------------------------------------
# User Shell Environment
#-------------------------------------------------------------------------------

# Set default prompt if interactive
test -n "$PS1" && prompt_color

# Condense path variables
PATH=$(puniq $PATH)
MANPATH=$(puniq $MANPATH)
export PATH
