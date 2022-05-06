# /etc/skel/.bash_profile

# This file is sourced by bash for login shells.  The following line
# runs your .bashrc and is recommended by the bash info pages.
if [[ -f ~/.bashrc ]] ; then
	. ~/.bashrc
fi

# Automatically start X.org
#if shopt -q login_shell; then
#	[[ -f ~/.bashrc ]] && source ~/.bashrc
#	[[ -t 0 && $(tty) == /dev/tty1 && ! $DISPLAY ]] && exec startx -- vt7
#else
#	exit 1 # Somehow this is a non-bash or non-login shell.
#fi
