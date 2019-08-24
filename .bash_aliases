# From Ubuntu's .bashrc
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# emacs
alias emacs='emacs -nw'

# Track configuration files using Git bare repo. See
# https://www.atlassian.com/git/tutorials/dotfiles for more info.
alias config='/usr/bin/git --git-dir=$HOME/dotfiles.git/ --work-tree=$HOME'