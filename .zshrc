# _____     _      _____         _   _              _____         ___ _
# |__   |___| |_   | __  |_ _ ___| |_|_|_____ ___   |     |___ ___|  _|_|___
# |   __|_ -|   |  |    -| | |   |  _| |     | -_|  |   --| . |   |  _| | . |
# |_____|___|_|_|  |__|__|___|_|_|_| |_|_|_|_|___|  |_____|___|_|_|_| |_|_  |
#                                                                       |___|

# import utility methods
. ./.utilities.sh

# =================
# Sourced Scripts
# =================

# # A welcome prompt with stats for sanity checks
# if [ -f ~/.welcome_prompt.sh ]; then
#   source ~/.welcome_prompt.sh
# fi

# Builds the prompt with git branch notifications.
# if [ -f ~/.bash_prompt.zsh ]; then
#   source ~/.bash_prompt.zsh
# fi

if [ -f /usr/local/etc/bash-completion/bash_completion ]; then
  . /usr/local/etc/bash-completion/bash_completion
fi

# Load Git completion
if [ -f ~/.git_completion.zsh ]; then
  zstyle ':completion:*:*:git:*' script ~/.git_completion.zsh
  fpath=(~/.zsh $fpath)

  autoload -Uz compinit && compinit
fi

__git_files () {
  _wanted files expl 'local files' _files
}

# =================
# Build the Prompt
# =================
NEWLINE=$'\n'

PROMPT="%{$WHITE%}%n%{$reset_color%} "          # Username
PROMPT+="%{$CYAN%}%~ %{$reset_color%}"          # Working directory
# PROMPT+="${NEWLINE}"                            # Newline
PROMPT+="%{$RED%}% Җ %{$reset_color%} "         # Custom prompt
PROMPT+="%{$WHITE%}%"                           # Style for input

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
    echo "%{$fg[grey]%}${vcs_info_msg_0_}%{$reset_color%}$del"
  fi
}
RPROMPT=$'$(vcs_info_wrapper)'
