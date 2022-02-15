# _____     _      _____
# |__   |___| |_   |   __|___ _ _
# |   __|_ -|   |  |   __|   | | |
# |_____|___|_|_|  |_____|_|_|\_/
#

# =================
# Paths
# =================
# A list of all directories in which to look for commands, scripts and programs

# Example Path:
# PATH="/usr/local/bin/npm:$PATH"                            # NPM

# =================
# Settings
# =================

# Prefer US English
export LC_ALL="en_US.UTF-8"
# use UTF-8
export LANG="en_US"

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

# Below here is an area for other commands added by outside programs or
# commands. Attempt to reserve this area for their use!
##########################################################################
