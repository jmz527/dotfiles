# -----------------------------------------------------------------------------
# Path
# A list of all directories in which to look for commands, scripts and programs
# -----------------------------------------------------------------------------

PATH="$HOME/.rbenv/bin:$PATH"                              # RBENV
PATH="/usr/local/bin/npm:$PATH"                            # NPM
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

# ====================================
# Environmental Variables and API Keys
# ====================================

# Python virtualenvwrapper settings
# export WORKON_HOME='~/envs'
# export PIP_VIRTUALENV_BASE=$WORKON_HOME
# export VIRTUALENVWRAPPER_PYTHON='/usr/local/bin/python3'
# export VIRTUALENVWRAPPER_VIRTUALENV='/usr/local/bin/virtualenv'
# export VIRTUALENVWRAPPER_SCRIPT='/usr/local/bin/virtualenvwrapper.sh'
# source '/usr/local/bin/virtualenvwrapper_lazy.sh'

# Below here is an area for other commands added by outside programs or
# commands. Attempt to reserve this area for their use!
##########################################################################
# export PATH="/usr/local/opt/icu4c/bin:$PATH"
# export PATH="/usr/local/opt/icu4c/sbin:$PATH"

# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*