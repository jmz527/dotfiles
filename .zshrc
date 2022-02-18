# _____     _      _____         _   _              _____         ___ _
# |__   |___| |_   | __  |_ _ ___| |_|_|_____ ___   |     |___ ___|  _|_|___
# |   __|_ -|   |  |    -| | |   |  _| |     | -_|  |   --| . |   |  _| | . |
# |_____|___|_|_|  |__|__|___|_|_|_| |_|_|_|_|___|  |_____|___|_|_|_| |_|_  |
#                                                                       |___|

# This sets the environment for interactive shells. This gets loaded after .zprofile.
# It's typically a place where you "set it and forget it" type of parameters like $PATH,
# $PROMPT, aliases, and functions you would like to have in both login and interactive shells.

# import utility methods
. ~/.utilities.sh

# =================
# Sourced Scripts
# =================

# Bash completion
if [ -f /usr/local/etc/bash-completion/bash_completion ]; then
  . /usr/local/etc/bash-completion/bash_completion
fi

# Load Git completion
# if [ -f ~/.git_completion.zsh ]; then
#   zstyle ':completion:*:*:git:*' script ~/.git_completion.zsh
#   fpath=(~/.zsh $fpath)
#
#   autoload -Uz compinit && compinit
# fi

__git_files () {
  _wanted files expl 'local files' _files
}

# =================
# Build the Prompt
# =================
PROMPT="%{$WHITE%}%n%{$RESET%} "          # Username
PROMPT+="%{$CYAN%}%~ %{$RESET%}"          # Working directory
PROMPT+="%{$RED%}% Җ %{$RESET%} "         # Custom prompt
PROMPT+="%{$WHITE%}%"                     # Style for input

# Show the git branch on the right:
setopt prompt_subst
autoload -Uz vcs_info
zstyle ':vcs_info:*' actionformats \
    '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats       \
    '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'

zstyle ':vcs_info:*' enable git cvs svn

# or use pre_cmd, see man zshcontrib
vcs_info_wrapper() {
  vcs_info
  if [ -n "$vcs_info_msg_0_" ]; then
    echo "%{$fg[grey]%}${vcs_info_msg_0_}%{$RESET%}$del"
  fi
}
RPROMPT=$'$(vcs_info_wrapper)'
