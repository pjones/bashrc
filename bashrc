#!/bin/bash

################################################################################
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

################################################################################
# Environment variables:
export VIRSH_DEFAULT_CONNECT_URI="qemu:///system"
export GPG_TTY=$(tty)

if type -t e > /dev/null ; then
  export EDITOR=e # Emacs!
else
  export EDITOR=vi
fi

################################################################################
# Aliases:
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
alias nix-unstable='nix-shell -I nixpkgs=https://github.com/NixOS/nixpkgs-channels/tarball/nixpkgs-unstable'

################################################################################
# Interactive functions:
function get() {
  curl -Lo "$(basename "$1")" "$1"
}

################################################################################
# Prompt:
function indicate_nonzero_return() {
  RETVAL=$?

  if [ "$RETVAL" -ne 0 ]; then
    echo "($RETVAL) "
  fi
}

function indicate_nix_shell_status() {
  if [ -n "$NIX_BUILD_TOP" ]; then
    echo "{ λ = nix; } "
  fi
}

function restore_prompt_after_nix_shell() {
  if [ "$PS1" != "$PROMPT" ]; then
    PS1=$PROMPT
    PROMPT_COMMAND=""
  fi
}

PROMPT_COMMAND=restore_prompt_after_nix_shell
PROMPT='\[\e[35m\][ \[\e[34m\]\u\[\e[31m\]@\[\e[32m\]\h\[\e[33m\]:\w \[\e[31m\]$(indicate_nonzero_return)\[\e[34m\]$(indicate_nix_shell_status)\[\e[35m\]]\[\e[m\]\n$ '
export PS1=$PROMPT
export PS2='> '
