#!/bin/sh

#-------------------------------------------------------------------------------
# Colors
#-------------------------------------------------------------------------------
# Set the TERM var to xterm-256color
if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
  export TERM=gnome-256color
elif infocmp xterm-256color >/dev/null 2>&1; then
  export TERM=xterm-256color
fi
if tput setaf 1 &> /dev/null; then
  tput sgr0
  # this is for xterm-256color
  if [[ $(tput colors) -ge 256 ]] 2>/dev/null; then
    # Foreground color
    BLACK=$(      tput setaf 0)
    RED=$(        tput setaf 1)
    GREEN=$(      tput setaf 2)
    YELLOW=$(     tput setaf 226)
    BLUE=$(       tput setaf 4)
    MAGENTA=$(    tput setaf 5)
    CYAN=$(       tput setaf 6)
    WHITE=$(      tput setaf 7)
    ORANGE=$(     tput setaf 172)
    PURPLE=$(     tput setaf 141)
    # Background color
    BG_BLACK=$(   tput setab 0)
    BG_RED=$(     tput setab 1)
    BG_GREEN=$(   tput setab 2)
    BG_BLUE=$(    tput setab 4)
    BG_MAGENTA=$( tput setab 5)
    BG_CYAN=$(    tput setab 6)
    BG_YELLOW=$(  tput setab 226)
    BG_ORANGE=$(  tput setab 172)
    BG_WHITE=$(   tput setab 7)
  else
    MAGENTA=$(    tput setaf 5)
    ORANGE=$(     tput setaf 4)
    GREEN=$(      tput setaf 2)
    PURPLE=$(     tput setaf 1)
    WHITE=$(      tput setaf 7)
  fi
  # Style
  UNDERLINE=$(    tput smul)
  NOUNDERLINE=$(  tput rmul)
  BOLD=$(         tput bold)
  RESET=$(        tput sgr0)
  UNDERLINE=$(    tput sgr 0 1)
  ITALIC=$(       tput sitm)
else
  BLACK="\[\e[0;30m\]"
  RED="\033[1;31m"
  ORANGE="\033[1;33m"
  GREEN="\033[1;32m"
  PURPLE="\033[1;35m"
  WHITE="\033[1;37m"
  YELLOW="\[\e[0;33m\]"
  CYAN="\[\e[0;36m\]"
  BLUE="\[\e[0;34m\]"
  BOLD=""
  RESET="\033[m"
fi
