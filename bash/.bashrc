# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

#> EXPORTS

# PS1
export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 2)\] \\$ \[$(tput sgr0)\]"

export TERMINAL=st

# Preferred editor: If neovim is found, use it; otherwise use vim
[ $(which nvim) ] && export EDITOR='nvim' || export EDITOR='vim'

# Correctly set language variables
export LANG="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_NUMERIC="it_IT.UTF-8"
export LC_TIME="it_IT.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_MONETARY="it_IT.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_PAPER="it_IT.UTF-8"
export LC_NAME="it_IT.UTF-8"
export LC_ADDRESS="it_IT.UTF-8"
export LC_TELEPHONE="it_IT.UTF-8"
export LC_MEASUREMENT="it_IT.UTF-8"
export LC_IDENTIFICATION="it_IT.UTF-8"

# Colored man pages (& less colors)
export LESS_TERMCAP_mb=$(tput bold; tput setaf 2) # green
export LESS_TERMCAP_md=$(tput bold; tput setaf 3) # yellow
export LESS_TERMCAP_me=$(tput sgr0)
export LESS_TERMCAP_so=$(tput bold; tput setaf 3; tput setab 4) # yellow on blue
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 7) # white
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)
export LESS_TERMCAP_mr=$(tput rev)
export LESS_TERMCAP_mh=$(tput dim)
export LESS_TERMCAP_ZN=$(tput ssubm)
export LESS_TERMCAP_ZV=$(tput rsubm)
export LESS_TERMCAP_ZO=$(tput ssupm)
export LESS_TERMCAP_ZW=$(tput rsupm)
export GROFF_NO_SGR=1         # For Konsole and Gnome-terminal


# Add $HOME/.local/bin and $HOME/.config/scripts
# to PATH so any script in that directory is executable
export PATH="$HOME/.local/bin:$HOME/.config/scripts:$PATH"

# Colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
export CC="gcc"

# Key timeout for Vim mode
export KEYTIMEOUT=1

# Set default Browser
export BROWSER="librewolf"

# Fix gpg
export GPG_TTY=$(tty)

# NNN settings
export NNN_BMS="d:$HOME/Documents;D:$HOME/Downloads;h:$HOME;m:$HOME/Music;p:$HOME/Pictures;s:/media/matteo/ssd"
export NNN_FIFO="/tmp/nnn.fifo"
export NNN_PLUG="d:diffs;e:suedit;f:fixname;i:imgview;m:mp3conv;n:bulknew;p:picker;t:preview-tui;u:getplugs;v:preview-tabbed"

# Xauthority
export XAUTHORITY=$HOME/.Xauthority

# Surfraw
export SURFRAW_text_browser="/usr/bin/elinks"
export SURFRAW_graphical=yes

# set dbus for remote SSH connections
if [ -n "$SSH_CLIENT" -a -n "$DISPLAY" ]; then
    machine_id=$(LANGUAGE=C hostnamectl|grep 'Machine ID:'| sed 's/^.*: //')
    x_display=$(echo $DISPLAY|sed 's/^.*:\([0-9]\+\)\(\.[0-9]\+\)*$/\1/')
    dbus_session_file="$HOME/.dbus/session-bus/${machine_id}-${x_display}"
    if [ -r "$dbus_session_file" ]; then
            export $(grep '^DBUS.*=' "$dbus_session_file")
            # check if PID still running, if not launch dbus
            ps $DBUS_SESSION_BUS_PID | tail -1 | grep dbus-daemon >& /dev/null
            [ "$?" != "0" ] && export $(dbus-launch) >& /dev/null
    else
            export $(dbus-launch) >& /dev/null
    fi
fi

#> FUNCTIONS

# Send mail from terminal
# Usage: compose SUBJECT DEST
compose() {
	neomutt -s $1 $2
}

# Empty trash (.local/share/Trash)
empty-trash() {
	printf "Do you really want to empty the Trash? [y/n] "
	read emptytrash
	case $emptytrash in
		y|Y)
			printf "Emptying trash...\n"
			rm -fr "~/.local/share/Trash/*"
			;;
		n|N)
			printf "Aborting...\n"
			;;
		*)
			printf "Unknown character, aborting!\n"
			;;
	esac
}

# Create a directory and cd into it
mkcd() {
	mkdir "$1" && cd "$1" || echo "Failed to create directory $1! "
}

# Encode a string in a qr code
qrencode() {
	curl "qrenco.de/$1"
}

# Uninstall APKs on android phone using ADB
rm-apk() {
	adb uninstall --user 0 "$1"
}

rm-apk-safe() {
	adb shell cmd package uninstall -k "$1"
}

# Download a song
song() {
	# Check if we have a second argument (save location)
	if [ ! -z "$2" ]; then
		save_loc="$2/%(title)s.%(ext)s"
	else
		save_loc="$(pwd)/%(title)s.%(ext)s"
	fi

	yt-dlp -x --embed-thumbnail --audio-format mp3 -f bestaudio \
		--audio-quality 0 -c -i "$1" -o $save_loc
}

# Convert any supported file to mp3
tomp3() {
	ffmpeg -i "$1" -b:a 320K -vn "$1.mp3"
}

# Convert any supported file to mp4
tomp4() {
	extension="${1##*.}"
	ffmpeg -i "$1" -codec copy "${1/$extension/mp4}"
	rm "$1"
}

#< END FUNCTIONS

#> SOURCES
# Bash completions
source /etc/bash/bashrc.d/bash_completion.sh

# Source aliases
source ~/.aliases

# Bash Line Editor (if we aren't in a TTY)
if [ "$TERM" != "linux" ]; then
	source ~/.local/share/blesh/ble.sh

	# BLE settings
	# Set autocomplete delay
	#bleopt complete_auto_delay=100
	# Set EOL string
	bleopt prompt_eol_mark='⏎'
	# Show current time at the right side of PS1
	#bleopt prompt_rps1='\t'
fi

#< END SOURCES

#> OTHERS
# If we're not in dvtm, launch nnn using dvtm
if [[ "$TERM" = "dvtm-256color" ]]; then
	alias n="nnn -e"
	alias nnn="nnn -e"
	PS1="[NNN] $PS1"
else
	alias n="dvtm 'nnn -e' 'nnn -e'"
	alias nnn="dvtm 'nnn -e' 'nnn -e'"
fi

# Vim mode
#set editing-mode vi
set -o vi

#< END OTHERS

clear; echo "Successfully started bash"
