#!/bin/sh
# _____     _
# |   __|___| |_ _ _ ___
# |__   | -_|  _| | | . |
# |_____|___|_| |___|  _|
#                   |_|

# import utility methods
. ./.utilities.sh

check_for_command cp
check_for_directory ~/

# methods
FILES_EXIST=false
dotfile_check () {
  if [ -f $1 ]; then
    show "file exists: $1"
    FILES_EXIST=true
  else
    show "file does not exist: $1"
  fi
}

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

show "    ${BOLD}Welcome to the Dotfiles Setup Script! ${RESET}"
show "";
inform "This script will configure your shell environment." true
show "";
pause_awhile "Ready to begin?"

show "${BOLD}Checking for existing files...${RESET}" true
show "";
dotfile_check ~/.archey.sh
dotfile_check ~/.bash_prompt.zsh
dotfile_check ~/.git_completion.zsh
dotfile_check ~/.utilities.sh
dotfile_check ~/.zlogin
dotfile_check ~/.zlogout
dotfile_check ~/.zprofile
dotfile_check ~/.zshenv
dotfile_check ~/.zshrc

if [[ $FILES_EXIST == true ]]; then
  warn "${BOLD}WARNING:${RESET}" true
  warn "${BOLD}Pre-existing dotenv files have been detected.${RESET}"
  warn "${BOLD}These files will be overwritten.${RESET}"
  pause_and_warn "" true
else
  inform "Pre-existing dotenv files not detected." true
  pause_awhile "Ready to install the files?" true
fi

show "${BOLD}Copying files to your home directory...${RESET}" true
show "";

cp -v .archey.sh ~/
cp -v .bash_prompt.zsh ~/
cp -v .git_completion.zsh ~/
cp -v .utilities.sh ~/
cp -v .zlogin ~/
cp -v .zlogout ~/
cp -v .zprofile ~/
cp -v .zshenv ~/
cp -v .zshrc ~/
show "Complete!" true

show "${BOLD}Checking to make sure installation went as planned...${RESET}" true
check_for_directory ~/
check_for_file ~/.archey.sh
check_for_file ~/.bash_prompt.zsh
check_for_file ~/.git_completion.zsh
check_for_file ~/.utilities.sh
check_for_file ~/.zlogin
check_for_file ~/.zlogout
check_for_file ~/.zprofile
check_for_file ~/.zshenv
check_for_file ~/.zshrc
inform "All files accounted for! You are good to go!" true

show "${BOLD}Just one more thing...${RESET}" true
warn "In order for your changes to take effect you will need to" true
warn "close out this terminal and open a new one."
show "If you want to start over from scratch you can run the .tear_down.sh script." true
inform "The .tear_down.sh script removes all the dotfiles we just installed" true
inform "to your home directory."
show "Complete!" true
