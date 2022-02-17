# _____    _____         ___ _ _
# |__   |  |  _  |___ ___|  _|_| |___
# |   __|  |   __|  _| . |  _| | | -_|
# |_____|  |__|  |_| |___|_| |_|_|___|

# .zlogin and .zprofile are basically the same thing - they set the environment
# for login shells; they just get loaded at different times (see below). .zprofile
# is based on the Bash's .bash_profile while .zlogin is a derivative of CSH's .login.
# Since Bash was the default shell for everything up to Mojave, stick with .zprofile.

# ====================
# Aliases
# ====================

# Example alias. Entering 'classy' into your CLI will open up three tabs in chrome:
# alias classy="chrome 'http://www.rainymood.com' | \
#               chrome 'http://www.infinitelooper.com/?v=HMnrl0tmd3k&p=n' | \
#               chrome 'http://www.infinitelooper.com/?v=fsD1zoI7NYo'"

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
alias reload="clear; source ~/.zprofile"

# confirm before executing and be verbose
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias mkdir='mkdir -pv'

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
alias atom='/Applications/Atom.app/Contents/MacOS/Atom'
alias vs='/Applications/Visual\ Studio\ Code.app/Contents/MacOS/Electron'

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

# Git aliases
alias git_map='git log --graph --full-history --all --color --pretty=format:"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s"'

# SQL aliases
alias sqlite3='/usr/bin/sqlite3 -column -header'

# =================
# Methods
# =================

shortcut() {
  DEFAULT_TAIL="_branch"
  str="$1"
  SCID=$str[(ws:_sc-:)3]
  echo "SCid: ${SCID}"

  while true; do
    echo "What should the tail be?"
    echo "If not, your tag message will be the following: "
    echo "  $DEFAULT_TAIL"; echo "";
    read "TAIL?Enter tail here: ";

    if [[ -z "$TAIL" ]]; then
      TAIL="$DEFAULT_TAIL";
      break;
    elif [[ -n "$TAIL" ]]; then
      break;
    fi

  done

  if [[ -z $SCID ]]; then
    echo "\e[1;31mShortcut Issue ID required\e[0m"
  else
    git checkout -b "sc$SCID$TAIL"
    git commit -m "[sc$SCID$TAIL] new branch initial commit" --allow-empty
  fi
}

# =====================
# Resources
# =====================

# http://zsh.sourceforge.net/Intro/intro_3.html

# Old:
# http://cli.learncodethehardway.org/bash_cheat_sheet.pdf
# http://ss64.com/bash/syntax-prompt.html
# https://dougbarton.us/Bash/Bash-prompts.html
# http://sage.ucsc.edu/xtal/iterm_tab_customization.html
