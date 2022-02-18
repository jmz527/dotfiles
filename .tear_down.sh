#!/bin/sh

# import utility methods
. ./.utilities.sh

check_for_command rm
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

# Begin tear down script
show "${BOLD}Executing tear down script...${RESET}" true
inform "This script will remove several files from your home directory." true

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
  warn "${BOLD}If you have made any custom edits to any of your dotfiles, you might want${RESET}"
  warn "${BOLD}to save them before continuing. Otherwise those changes will be lost.${RESET}"
  pause_and_warn "" true

  show "";
  show "${BOLD}Removing files...${RESET}" true
  inform "Files removed:" true
  show "";
  rm -fv ~/.archey.sh
  rm -fv ~/.bash_prompt.zsh
  rm -fv ~/.git_completion.zsh
  rm -fv ~/.utilities.sh
  rm -fv ~/.zlogin
  rm -fv ~/.zlogout
  rm -fv ~/.zprofile
  rm -fv ~/.zshenv
  rm -fv ~/.zshrc
  show "Complete!" true

else
  warn "Dotenv files not detected." true
fi
