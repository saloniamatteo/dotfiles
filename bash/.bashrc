# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

# Launch tmux if available, and if TERM is not screen or tmux
if command -v tmux &> /dev/null && [[ ! "$TERM" == linux ]] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux
fi

#> EXPORTS

# Colored LS output
export LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:su=37;41:sg=30;43:ca=00:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.avif=01;35:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.cfg=00;32:*.conf=00;32:*.diff=00;32:*.doc=00;32:*.ini=00;32:*.log=00;32:*.patch=00;32:*.pdf=00;32:*.ps=00;32:*.tex=00;32:*.txt=00;32:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:*~=00;90:*#=00;90:*.bak=00;90:*.old=00;90:*.orig=00;90:*.part=00;90:*.rej=00;90:*.swp=00;90:*.tmp=00;90:*.dpkg-dist=00;90:*.dpkg-old=00;90:*.ucf-dist=00;90:*.ucf-new=00;90:*.ucf-old=00;90:*.rpmnew=00;90:*.rpmorig=00;90:*.rpmsave=00;90:';
export DIR_COLORS=$LS_COLORS

# Colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
export CC="gcc"

# PS1
export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 2)\] \\$ \[$(tput sgr0)\]"

# Preferred editor: If neovim is found, use it; otherwise use vim
command -v nvim &> /dev/null && export EDITOR='nvim' || export EDITOR='vim'

# Correctly set language variables
# LANG is the system language (en_US),
# the rest is localization    (it_IT)
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

# Extend PATH
export PATH="$HOME/.local/bin:$HOME/.config/scripts:/etc/eselect/wine/bin:$PATH"

# Key timeout for Vim mode
export KEYTIMEOUT=1

# Set default Browser
command -v librewolf-bin &> /dev/null && export BROWSER="librewolf-bin"

# Use GPG with SSH
export GPG_TTY=$(tty)

# SSH askpass
command -v lxqt-openssh-askpass &> /dev/null && export SSH_ASKPASS="$(which lxqt-openssh-askpass)"

# Xauthority
# Uncomment this line if you DON'T use a display manager
# (as in, you run "startx", or the DE/WM directly.)
export XAUTHORITY=$HOME/.Xauthority

# Wine settings
export WINEFSYNC=1
export WINE_LARGE_ADDRESS_AWARE=1

# CTRL-R -> Paste the selected command from history onto the command-line
# Change "copyq copy -" if you don't use CopyQ as your clipboard implementation
# with something like "xclip", "xsel", or "pbcopy".
export FZF_CTRL_R_OPTS="
  --bind 'ctrl-y:execute-silent(echo -n {2..} | copyq copy -)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

# Use 'qq' as the completion trigger instead of '~~'
export FZF_COMPLETION_TRIGGER='qq'

# Options for path completion (e.g. vim **<TAB>)
#export FZF_COMPLETION_PATH_OPTS='--walker file,dir,follow,hidden'
export FZF_COMPLETION_PATH_OPTS='--walker file,dir,follow'

# Options for directory completion (e.g. cd **<TAB>)
export FZF_COMPLETION_DIR_OPTS='--walker dir,follow'

#> FUNCTIONS
# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments ($@) to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'tree -C {} | head -200'   "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview 'bat -n --color=always {}' "$@" ;;
  esac
}

# Remove colors from file (ANSI escape sequences)
decolorise() {
	sed 's/\x1B[@A-Z\\\]^_]\|\x1B\[[0-9:;<=>?]*[-!"#$%&'"'"'()*+,.\/]*[][\\@A-Z^_`a-z{|}~]//g' "$1"
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

restore-apk() {
	adb shell cmd package install-existing "$1"
}

# Install DXVK & VKD3D in WINEPREFIX
setup_wine() {
	echo "Setting up DXVK and VKD3D in WINEPREFIX: $WINEPREFIX"
	setup_dxvk.sh install --symlink
	setup_vkd3d_proton.sh install --symlink
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

# Convert image to webp
# If $2 is "-d", remove original picture
towebp() {
	extension="${1##*.}"
	cwebp "$1" -o "${1/$extension/webp}"

	if [ "$2" == '-d' ]; then
		rm "$1"
	fi
}

# Convert image to webp (higher quality)
# If $2 is "-d", remove original picture
towebp_hi() {
	extension="${1##*.}"
	cwebp -z 6 "$1" -o "${1/$extension/webp}"

	if [ "$2" == '-d' ]; then
		rm "$1"
	fi
}

# Convert any supported file to mp3
tomp3() {
	extension="${1##*.}"
	ffmpeg -i "$1" -b:a 320K -vn "${1/$extension/mp3}"
}

# Convert any supported file to mp4
tomp4() {
	extension="${1##*.}"
	ffmpeg -i "$1" -codec copy "${1/$extension/mp4}"
}
#< END FUNCTIONS

#> SOURCES
# Bash completions
source /etc/bash/bashrc.d/bash_completion.sh

# Source aliases
source ~/.aliases

# BLE
source ~/.local/share/blesh/ble.sh

# fzf tab completions
source /usr/share/bash-completion/completions/fzf
source /usr/share/fzf/key-bindings.bash
# OR
#ble-import integration/fzf-completion
#ble-import integration/fzf-key-bindings
#ble-import integration/fzf-menu

# Disable cd builtin completion to use with fzf
ble-import -C 'unset -f ble/cmdinfo/complete:cd' core-complete

# Show git info in RPS1. The following are shown:
# - directory name
# - branch
# - commit hash
# - path (relative to root directory)
ble-import contrib/prompt-git

# Show command exec time in RPS1
ble-import contrib/prompt-elapsed
#< END SOURCES

#> OTHERS
# BLE (https://github.com/akinomyoga/ble.sh) settings
# RPS1: show command exec time + git info (if available)
bleopt prompt_rps1='\g{fg=69,italic}\q{contrib/elapsed} \g{fg=7}\q{contrib/git-info}'
#bleopt prompt_rps1='\g{fg=69,italic}\q{contrib/elapsed}'

# Share history between sessions
bleopt history_share=1

# Completions must finish within 1.25 seconds
bleopt complete_limit_auto=1250
bleopt complete_timeout_auto=1250
#bleopt complete_limit_auto_menu=100
#bleopt complete_polling_cycle=50
#bleopt complete_timeout_compvar=200

# Set BLE EOL string
bleopt prompt_eol_mark='⏎'

if [ "$TERM" == "linux" ]; then
	# this option specifies whether the commands called from the blehook PRECMD
	# or the variable PROMPT_COMMAND output texts to the terminal and changes the layout.
	# when a non-empty value is specified, ble.sh resets the layout before
	# running the hooks PRECMD and PROMPT_COMMAND and restores the layout after running the hooks.
	# when a empty value is specified, ble.sh assumes that these hooks do not output texts to
	# the terminal and do not changes the cursor positions and skip the special treatment.
	bleopt prompt_command_changes_layout=1
fi


# Vim mode
#set editing-mode vi
set -o vi

# "doas" bash completion
# If you have app-shells/bash-completion installed
complete -F _root_command doas
# ------------------------------------------------
# The following doesn't require bash-completion,
# however it doesn't complete arguments
#complete -cf doas

# FUCK!
# (Command correction)
# https://github.com/nvbn/thefuck
command -v thefuck &> /dev/null && eval "$(thefuck --alias)"

# Launch keychain (ssh-agent management)
# https://github.com/funtoo/keychain
# Do this only if not under linux terminal
if [ $TERM != "linux" ]; then
    # Only run keychain if ssh-agent is running already
    if ! [ -z $(pidof ssh-agent) ]; then
      eval "$(keychain --eval --agents ssh id_rsa)"
    fi
fi
#< END OTHERS

# Hand over shell to user
clear; echo "Successfully started bash"
