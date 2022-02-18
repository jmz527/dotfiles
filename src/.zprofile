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

# Easier navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias back="cd -"

# mv, rm, cp - confirm before executing and be verbose
alias cp='cp -i -v'
alias mv='mv -i -v'
alias rm='rm -i -v'

alias where=which # sometimes i forget

# ls
hash gls >/dev/null 2>&1 || alias gls="ls" # use coreutils `ls` if possible…

# always use color, even when piping (to awk,grep,etc)
if gls --color > /dev/null 2>&1; then colorflag="--color"; else colorflag="-G"; fi;
export CLICOLOR_FORCE=1

# ls options: A = include hidden (but not . or ..), F = put `/` after folders, h = byte unit suffixes
alias ls='gls -AFh ${colorflag} --group-directories-first'
alias lsa='gls -laFh ${colorflag} --group-directories-first' # long list format
alias lsd='ls -l | grep "^d"' # only directories
#    `la` defined in methods

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

alias sqlite3='/usr/bin/sqlite3 -column -header'

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

# Recursively delete `.DS_Store` files
alias cleanup_dsstore="find . -name '*.DS_Store' -type f -ls -delete"

# Empty the Trash on the main HDD
alias empty_trash="rm -rfv ~/.Trash/*;"

# History lists your previously entered commands
alias h='history'

# If we make a change to our bash profile we need to reload it
alias reload="clear; source ~/.zprofile"

# Git aliases
alias git_map='git log --graph --full-history --all --color --pretty=format:"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s"'

# =================
# Methods
# =================

# Create a new directory and enter it
function mkd () {
	mkdir -p -v "$@" && cd "$@"
}

# find shorthand
function f () {
	find . -name "$1" 2>&1 | grep -v 'Permission denied'
}

# List all files, long format, colorized, permissions in octal
function la () {
  ls -l  "$@" | awk '
    {
      k=0;
      for (i=0;i<=8;i++)
        k+=((substr($1,i+2,1)~/[rwx]/) *2^(8-i));
      if (k)
        printf("%0o ",k);
      printf(" %9s  %3s %2s %5s  %6s  %s %s %s\n", $3, $6, $7, $8, $5, $9,$10, $11);
    }'
}

# cd into whatever is the forefront Finder window.
cdfinder () {
  cd "`osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)'`"
}

# git commit browser. needs fzf
log () {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --toggle-sort=\` \
      --bind "ctrl-m:execute:
                echo '{}' | grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R'"
}


# Start an HTTP server from a directory, optionally specifying the port
function server () {
	local port="${1:-8011}"
	open "http://localhost:${port}/" &
  # statikk is good because it won't expose hidden folders/files by default.
  # npm install -g statikk
  statikk --port "$port" .
}

# Copy w/ progress
cp_p () {
  rsync -WavP --human-readable --progress $1 $2
}

# get gzipped size
function gz () {
	echo "orig size    (bytes): "
	cat "$1" | wc -c
	echo "gzipped size (bytes): "
	gzip -c "$1" | wc -c
}

# whois a domain or a URL
function whois () {
	local domain=$(echo "$1" | awk -F/ '{print $3}') # get domain from URL
	if [ -z $domain ] ; then
		domain=$1
	fi
	echo "Getting whois record for: $domain …"

	# avoid recursion
					# this is the best whois server
													# strip extra fluff
	/usr/bin/whois -h whois.internic.net $domain | sed '/NOTICE:/q'
}

function localip () {
  PURPLE="\033[1;35m"
  RESET="\033[m"
	function _localip() { echo "📶  "$(ipconfig getifaddr "$1"); }
	export -f _localip
	local purple="\x1B\[35m" reset="\x1B\[m"
	networksetup -listallhardwareports | \
		sed -r "s/Hardware Port: (.*)/${PURPLE}\1${RESET}/g" | \
		sed -r "s/Device: (en.*)$/_localip \1/e" | \
		sed -r "s/Ethernet Address:/📘 /g" | \
		sed -r "s/(VLAN Configurations)|==*//g"
}

# preview csv files. source: http://stackoverflow.com/questions/1875305/command-line-csv-viewer
function csvpreview () {
  sed 's/,,/, ,/g;s/,,/, ,/g' "$@" | column -s, -t | less -#2 -N -S
}

# Extract archives - use: extract <file>
# Based on http://dotfiles.org/~pseup/.bashrc
function extract () {
	if [ -f "$1" ] ; then
		local filename=$(basename "$1")
		local foldername="${filename%%.*}"
		local fullpath=`perl -e 'use Cwd "abs_path";print abs_path(shift)' "$1"`
		local didfolderexist=false
		if [ -d "$foldername" ]; then
			didfolderexist=true
			read -p "$foldername already exists, do you want to overwrite it? (y/n) " -n 1
			echo
			if [[ $REPLY =~ ^[Nn]$ ]]; then
				return
			fi
		fi
		mkdir -p "$foldername" && cd "$foldername"
		case $1 in
			*.tar.bz2) tar xjf "$fullpath" ;;
			*.tar.gz) tar xzf "$fullpath" ;;
			*.tar.xz) tar Jxvf "$fullpath" ;;
			*.tar.Z) tar xzf "$fullpath" ;;
			*.tar) tar xf "$fullpath" ;;
			*.taz) tar xzf "$fullpath" ;;
			*.tb2) tar xjf "$fullpath" ;;
			*.tbz) tar xjf "$fullpath" ;;
			*.tbz2) tar xjf "$fullpath" ;;
			*.tgz) tar xzf "$fullpath" ;;
			*.txz) tar Jxvf "$fullpath" ;;
			*.zip) unzip "$fullpath" ;;
			*) echo "'$1' cannot be extracted via extract()" && cd .. && ! $didfolderexist && rm -r "$foldername" ;;
		esac
	else
		echo "'$1' is not a valid file"
	fi
}

# who is using the laptop's iSight camera?
camerausedby () {
	echo "Checking to see who is using the iSight camera… 📷"
	usedby=$(lsof | grep -w "AppleCamera\|USBVDC\|iSight" | awk '{printf $2"\n"}' | xargs ps)
	echo -e "Recent camera uses:\n$usedby"
}

# animated gifs from any video
# from alex sexton   gist.github.com/SlexAxton/4989674
gifify () {
  if [[ -n "$1" ]]; then
	if [[ $2 == '--good' ]]; then
	  ffmpeg -i "$1" -r 10 -vcodec png out-static-%05d.png
	  time convert -verbose +dither -layers Optimize -resize 900x900\> out-static*.png  GIF:- | gifsicle --colors 128 --delay=5 --loop --optimize=3 --multifile - > "$1.gif"
	  rm -f out-static*.png
	else
	  ffmpeg -i "$1" -s 600x400 -pix_fmt rgb24 -r 10 -f gif - | gifsicle --optimize=3 --delay=3 > "$1.gif"
	fi
  else
	echo "proper usage: gifify <input_movie.mov>. You DO need to include extension."
  fi
}

# turn that video into webm.
# brew reinstall ffmpeg --with-libvpx
webmify () {
	ffmpeg -i "$1" -vcodec libvpx -acodec libvorbis -isync -copyts -aq 80 -threads 3 -qmax 30 -y "$2" "$1.webm"
}

# direct it all to /dev/null
function nullify () {
  "$@" >/dev/null 2>&1
}

# `shellswitch [bash |zsh]`
#   Must be in /etc/shells
shellswitch () {
	chsh -s $(brew --prefix)/bin/$1
}

shortcut () {
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

# https://github.com/paulirish/dotfiles
# http://zsh.sourceforge.net/Intro/intro_3.html

# Old:
# http://cli.learncodethehardway.org/bash_cheat_sheet.pdf
# http://ss64.com/bash/syntax-prompt.html
# https://dougbarton.us/Bash/Bash-prompts.html
# http://sage.ucsc.edu/xtal/iterm_tab_customization.html
