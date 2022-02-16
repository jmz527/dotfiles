#!/bin/sh
# _____     _
# |   __|___| |_ _ _ ___
# |__   | -_|  _| | | . |
# |_____|___|_| |___|  _|
#                   |_|

# set -o errexit

# import utility methods
. ./.utilities.sh

#-------------------------------------------------------------------------------
# We begin!
#-------------------------------------------------------------------------------

# Run archey for dramatic effect
./.archey.zsh

show "${BOLD}Welcome to the Dotfiles Setup! ${RESET}"
inform "This script will configure your shell environment."

pause_awhile "Ready to begin?"

cp -iv .archey.zsh ~/.
cp -iv .bash_prompt.zsh ~/.
cp -iv .git_completion.zsh ~/.
cp -iv .utilities.sh ~/.
cp -iv .zlogin ~/.
cp -iv .zlogout ~/.
cp -iv .zprofile ~/.
cp -iv .zshenv ~/.
cp -iv .zshrc ~/.
