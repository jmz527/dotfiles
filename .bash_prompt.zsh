# _____         _      _____                   _
# | __  |___ ___| |_   |  _  |___ ___ _____ ___| |_
# | __ -| .'|_ -|   |  |   __|  _| . |     | . |  _|
# |_____|__,|___|_|_|  |__|  |_| |___|_|_|_|  _|_|
#                                          |_|

# import utility methods
. ./.utilities.sh

# =================
# Style
# =================

style_user="\[${RESET}${WHITE}\]"
style_path="\[${RESET}${CYAN}\]"
style_chars="\[${RESET}${WHITE}\]"
style_branch="${RED}"

# =================
# Build
# =================
# Example with committed changes: username ~/documents/GA/wdi on master[+]

PS1="${style_user}\u"                    # Username
PS1+="${style_path} \w"                  # Working directory
PS1+="\$(prompt_git)"                    # Git details
PS1+="\n"                                # Newline
PS1+="${style_chars}\$ \[${RESET}\]"     # $ (and reset color)

# =================
# Prompt
# =================

# Show more information regarding git status in prompt
GIT_DIFF_IN_PROMPT=true

# Long git to show + ? !
is_git_repo() {
  $(git rev-parse --is-inside-work-tree &> /dev/null)
}

is_git_dir() {
  $(git rev-parse --is-inside-git-dir 2> /dev/null)
}

get_git_branch() {
  local branch_name
  # Get the short symbolic ref
  branch_name=$(git symbolic-ref --quiet --short HEAD 2> /dev/null) ||
  # If HEAD isn't a symbolic ref, get the short SHA
  branch_name=$(git rev-parse --short HEAD 2> /dev/null) ||
  # Otherwise, just give up
  branch_name="(unknown)"
  printf $branch_name
}

# Git status information
prompt_git() {
  local git_info git_state uc us ut st
  if ! is_git_repo || is_git_dir; then
      return 1
  fi
  git_info=$(get_git_branch)

  if $GIT_DIFF_IN_PROMPT; then
    # Check for uncommitted changes in the index
    if ! $(git diff --quiet --ignore-submodules --cached); then
        uc="+"
    fi
    # Check for unstaged changes
    if ! $(git diff-files --quiet --ignore-submodules --); then
        us="!"
    fi
    # Check for untracked files
    if [ -n "$(git ls-files --others --exclude-standard)" ]; then
        ut="${RED}?"
    fi
    # Check for stashed files
    if $(git rev-parse --verify refs/stash &>/dev/null); then
        st="$"
    fi
    git_state=$uc$us$ut$st
    # Combine the branch name and state information
    if [[ $git_state ]]; then
        git_info="$git_info${RESET}[$git_state${RESET}]"
    fi
  fi

  printf "${WHITE} on ${style_branch}${git_info}${RESET}"
}

#-------------------------------------------------------------------------------
# Functions to toggle stats on terminal load
#-------------------------------------------------------------------------------

welcome() {
  sed -i.bak s/WELCOME_PROMPT=false/WELCOME_PROMPT=true/g ~/.welcome_prompt.sh
  echo "Message returned."
}
unwelcome() {
  sed -i.bak s/WELCOME_PROMPT=true/WELCOME_PROMPT=false/g ~/.welcome_prompt.sh
  echo "Message removed. Type ${BOLD}welcome${RESET} to return the message."
}
