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

# Print flashy title for dramatic effect:
echo "
${RED#     }       ____      _   ___ _ _
${MAGENTA# }      |    \ ___| |_|  _|_| |___ ___
${CYAN#    }      |  |  | . |  _|  _| | | -_|_ -|
${GREEN#   }      |____/|___|_| |_| |_|_|___|___|
${CYAN#    }                          Setup Script
${RESET}
";

show "${BOLD}Welcome to the Dotfiles Setup Script! ${RESET}" true
inform "This script will configure your shell environment." true
show "";
pause_awhile "Ready to begin?"

cp -iv .archey.sh ~/.
cp -iv .bash_prompt.zsh ~/.
cp -iv .git_completion.zsh ~/.
cp -iv .utilities.sh ~/.
cp -iv .zlogin ~/.
cp -iv .zlogout ~/.
cp -iv .zprofile ~/.
cp -iv .zshenv ~/.
cp -iv .zshrc ~/.
