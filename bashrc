#!/bin/bash

################################################################################
# The rest of this file should only be used when the shell is
# interactive and I'm not using nix-shell:
if [[ $- == *i* ]] &&
  [ -z "$NIX_BUILD_TOP" ] &&
  [ -z "$DIRENV_DIR" ]; then

  ##############################################################################
  # Interactive functions:
  function get() {
    curl -Lo "$(basename "$1")" "$1"
  }

  ##############################################################################
  # Prompt:
  function indicate_nonzero_return() {
    RETVAL=$?

    if [ "$RETVAL" -ne 0 ]; then
      echo "($RETVAL) "
    fi
  }

  ##############################################################################
  # Shell settings:
  set -o notify
  shopt -s autocd
  shopt -s cmdhist
  shopt -s dotglob
  shopt -s extglob
  shopt -s failglob
  shopt -s globstar
  shopt -s histappend
  shopt -s histreedit
  shopt -s histverify
  shopt -s xpg_echo

  ##############################################################################
  # Environment variables:
  export VIRSH_DEFAULT_CONNECT_URI="qemu:///system"

  if type -t e >/dev/null; then
    export EDITOR=e # Emacs!
  else
    export EDITOR=vi
  fi

  ##############################################################################
  # Aliases:
  alias -- -='cd -'
  alias ls='\ls --color=auto --group-directories-first'
  alias lsa='ls -A'
  alias l='\ls -lhF --color=auto --group-directories-first'
  alias ll='l'
  alias la='l -A'
  alias df='df -hP'
  alias p='ps -ewwopid,ppid,user,pcpu,vsz,rss,comm,args'
  alias pg='p|egrep'
  alias mrs='mr -d ~ status'
  alias gpg=gpg2

  export PS1='\[\e[35m\][ \[\e[34m\]\u\[\e[31m\]@\[\e[32m\]\h\[\e[33m\]:\w \[\e[31m\]$(indicate_nonzero_return)\[\e[35m\]]\[\e[m\]\n> '
  export PS2='>> '
else
  export PS1='> '
  export PS2='>> '
fi
