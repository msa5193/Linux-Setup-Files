# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

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

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# .bashrc
function parse_git_branch () {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

function parse_mts_project () {

  [[ "$PWD" =~ working-copy ]] && pwd | sed 's,^\(.*working-copy/\)\?\([^/].*work\),\2,' | sed 's,^\(.*\)\?\([^/]*\/work.*\),\1,'
 
}

function mts_project () {
  echo [$(parse_mts_project)];
}
    




# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

source /home/abb62261/working-copy/test-farm/test-farm/util/toys/test-farm-helpers

PERL_MB_OPT="--install_base \"/home/abb62261/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/abb62261/perl5"; export PERL_MM_OPT;

#PS1='[\u@\h \W]\$ '  # Default
PS1='\[\e[1;32m\]\D{%D}|\t\[\e[1;36m\][\u $(mts_project)$(parse_git_branch) \W]\$\[\e[0m\] ' 
#PS1='\[\e[1;36m\][\u $(parse_git_branch) \W]\$\[\e[0m\] ' 



alias etd='echo $TESTDIR'
alias proj='echo $PROJECT'
alias remaketests='./CleanTests.pl; ./MakeTests.pl'
alias clearcache='sudo sh -c '"'"'echo 1 >/proc/sys/vm/drop_caches'"'"'; sudo sh -c '"'"'echo 2 >/proc/sys/vm/drop_caches'"'"'; sudo sh -c '"'"'echo 3 >/proc/sys/vm/drop_caches'"'"';'
alias burnin='ssh viaviadmin@ubuntu-burnin-lab'
alias upgrade='./RunAutoTest.pl --upgrade '
alias gersat='ssh root@ger-sat-linux-1'
alias mts-test-setup='cd /home/abb62261/working-copy/develop/work/hst/build/mts-module-embedded-x86_64-native; mts build module native; cd -'
alias mts-test='cd /home/abb62261/working-copy/develop/work/hst/build/mts-module-embedded-x86_64-native; mts build module native embedded; ctest -R; cd -'
alias mts-hst='cd /home/abb62261/working-copy/develop/work/hst/'

# Git aliases
alias gits='git status'
alias gitf='git fetch'
alias gitc='git commit -m'

function scpi {
    if [ $# -eq 1 ]
    then
         unit=--5800
    else
         unit=$2
    fi
    port=`getport --ip $1 $unit | tail -n 1`
    scpiclient --ip $1 --port $port
}

function viavnc {

        vncviewer $1 -name $1 &
}


