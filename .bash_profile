#  _              _                        __ _ _
# | |__  __ _ ___| |__    _ __  _ __ ___  / _(_) | ___
# | '_ \ / _` / __| '_ \  | '_ \| '__/ _ \| |_| | |/ _ \
# | |_) | (_| \__ \ | | | | |_) | | | (_) |  _| | |  __/
# |_.__/ \__,_|___/_| |_| | .__/|_|  \___/|_| |_|_|\___|
#                         |_|

# When Bash starts, it executes the commands in this script
# http://en.wikipedia.org/wiki/Bash_(Unix_shell)

# Written by Philip Lamplugh, Instructor General Assembly (2013)
# Updated by PJ Hughes, Instructor General Assembly (2013)

# =====================
# Resources
# =====================

# http://cli.learncodethehardway.org/bash_cheat_sheet.pdf
# http://ss64.com/bash/syntax-prompt.html
# https://dougbarton.us/Bash/Bash-prompts.html
# http://sage.ucsc.edu/xtal/iterm_tab_customization.html

# ====================
# TOC
# ====================
# --------------------
# System Settings
# --------------------
#  Path List
#  Settings
#  History
#  Aliases
#  Other System Settings
# --------------------
# Application Settings
# --------------------
#  Application Aliases
#  rbenv
# --------------------
# Other Settings
# --------------------
#  Shortcuts
#  Source Files
#  Environmental Variables and API Keys
#  Colophon

# -----------------------------------------------------------------------------
# Path
# A list of all directories in which to look for commands, scripts and programs
# -----------------------------------------------------------------------------

PATH="$HOME/.rbenv/bin:$PATH"                              # RBENV
PATH="/usr/local/share/npm/bin:$PATH"                      # NPM
PATH="/usr/local/bin:/usr/local/sbin:$PATH"                # Homebrew
PATH="/usr/local/heroku/bin:$PATH"                         # Heroku Toolbelt
PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"       # Coreutils
PATH="$HOME/.meteor:$PATH"                                 # Meteor
MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH" # Manual pages

# =================
# Settings
# =================

# Prefer US English
export LC_ALL="en_US.UTF-8"
# use UTF-8
export LANG="en_US"

# # Adds colors to LS!!!!
# export CLICOLOR=1
# # http://geoff.greer.fm/lscolors/
# # Describes what color to use for which attribute (files, folders etc.)
# export LSCOLORS=exfxcxdxbxegedabagacad # PJ: turned off
# export LS_COLORS="di=34;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:"

# =================
# History
# =================

# http://jorge.fbarr.net/2011/03/24/making-your-bash-history-more-efficient/
# Larger bash history (allow 32³ entries; default is 500)
export HISTSIZE=32768
export HISTFILESIZE=$HISTSIZE

# don't put duplicate lines in the history.
export HISTCONTROL=ignoredups

# ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# Make some commands not show up in history
export HISTIGNORE="h"

# ====================
# Aliases
# ====================

# LS lists information about files.
# show slashes for directories.
alias ls='ls -F'

# long list format including hidden files and include unit size
alias lsa='ls -la'

# go back one directory
alias b='cd ..'

# History lists your previously entered commands
alias h='history'

# If we make a change to our bash profile we need to reload it
alias reload="clear; source ~/.bash_profile"

# confirm before executing and be verbose
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias mkdir='mkdir -pv'

# =================
# Additional Aliases
# =================

# Hide/show all desktop icons (useful when presenting)
alias hide_desktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias show_desktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

# Hide/show hidden files in Finder
alias hide_files="defaults write com.apple.finder AppleShowAllFiles FALSE && killall Finder"
alias show_files="defaults write com.apple.finder AppleShowAllFiles TRUE && killall Finder"

# Switch on/off your wifi
alias airport_on="networksetup -setairportpower airport on"
alias airport_off="networksetup -setairportpower airport off"

# List any open internet sockets on several popular ports.
# Useful if a rogue server is running
# http://www.akadia.com/services/lsof_intro.html
# http://en.wikipedia.org/wiki/List_of_TCP_and_UDP_port_numbers
alias rogue='lsof -i TCP:3000 -i TCP:4567 -i TCP:8000 -i TCP:8888 -i TCP:6379'

# Simple python server
alias pyserv="python -m SimpleHTTPServer | chrome 'http://localhost:8000'"

# Python aliases
alias dj='python manage.py'
alias djserver='python manage.py runserver_plus'
alias djshell='python manage.py shell_plus --ptpython'

# opens three tabs in chrome
alias classy="chrome 'http://www.rainymood.com' | chrome 'http://www.infinitelooper.com/?v=HMnrl0tmd3k&p=n' | chrome 'http://www.infinitelooper.com/?v=fsD1zoI7NYo'"

# ================
# Application Aliases
# ================

alias chrome='open -a "Google Chrome"'
alias ff='open -a "FireFox"'
alias safari='open -a "Safari"'
alias slack='open -a "Slack"'
alias photobooth='open -a "Photo Booth"'
alias vlc='open -a "VLC"'
alias ss='open -a "Screen Sharing"'

alias subl='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'
alias sqll='/usr/bin/sqlite3 -column -header'

# =================
# rbenv
# =================

# start rbenv (our Ruby environment and version manager) on open
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# =================
# node (Mac first, then Ubuntu)
# =================

if which brew >/dev/null; then
  export NVM_DIR=$(brew --prefix)/var/nvm
  source $(brew --prefix nvm)/nvm.sh
else
  export NVM_DIR=~/.nvm
  source ~/.nvm/nvm.sh
fi

# =================
# Functions
# =================

#######################################
# Start an HTTP server from a directory
# Arguments:
#  Port (optional)
#######################################

server() {
  local port="${1:-8000}"
  open "http://localhost:${port}/"
  # Set the default Content-Type to `text/plain` instead of `application/octet-stream`
  # And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)

  # Simple Pythong Server:
  # python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port"

  # Simple Ruby Webrick Server:
  ruby -e "require 'webrick';server = WEBrick::HTTPServer.new(:Port=>${port},:DocumentRoot=>Dir::pwd );trap('INT'){ server.shutdown };server.start"
}

# =================
# Tab Improvements
# =================

## Tab improvements
# ## Might not need?
# bind 'set completion-ignore-case on'
# # make completions appear immediately after pressing TAB once
# bind 'set show-all-if-ambiguous on'
# bind 'TAB: menu-complete'

# =================
# Sourced Scripts
# =================

# Builds the prompt with git branch notifications.
if [ -f ~/.bash_prompt.sh ]; then
  source ~/.bash_prompt.sh
fi

# A welcome prompt with stats for sanity checks
if [ -f ~/.welcome_prompt.sh ]; then
  source ~/.welcome_prompt.sh
fi

# bash/zsh completion support for core Git.
if [ -f ~/.git-completion.bash ]; then
  source ~/.git-completion.bash
fi

# ====================================
# Environmental Variables and API Keys
# ====================================

# Python virtualenvwrapper settings
export WORKON_HOME='~/envs'
export PIP_VIRTUALENV_BASE=$WORKON_HOME
export VIRTUALENVWRAPPER_PYTHON='/usr/local/bin/python3'
export VIRTUALENVWRAPPER_VIRTUALENV='/usr/local/bin/virtualenv'
export VIRTUALENVWRAPPER_SCRIPT='/usr/local/bin/virtualenvwrapper.sh'
source '/usr/local/bin/virtualenvwrapper_lazy.sh'

# Below here is an area for other commands added by outside programs or
# commands. Attempt to reserve this area for their use!
##########################################################################
# export PATH="/usr/local/opt/icu4c/bin:$PATH"
# export PATH="/usr/local/opt/icu4c/sbin:$PATH"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
