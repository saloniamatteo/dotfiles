#!/bin/bash
# Salonia Matteo's dotfiles
# Install single components or copy configurations
# This script can be used on all systems, but the package
# installation process is only supported on systems that use
# pacman or portage (aka Arch or Gentoo). See README.

# Define color variables
REDBG_BOLD="\e[1;41m"
BLUEBG_BOLD="\e[1;44m"
BOLD_ULINE="\e[1;4m"
ENDCOL="\e[0m"

# Check if we're running as root
[ "$EUID" -eq 0 ] && printf "$REDBG_BOLD[ERROR] Do not run this script as root! $ENDCOL\n" && exit 1

# Check if we have to use "sudo" or "doas".
function get_root() {
	if ! [ -z $(which doas) ]; then
		root=doas 
	else if ! [ -z $(which sudo) ]; then
		root=sudo
	else
		printf "$REDBG_BOLD[ERROR] Unable to find doas and/or sudo! $ENDCOL\n" && return 1
	fi
	fi
}

printf "
 ____        _             _       
/ ___|  __ _| | ___  _ __ (_) __ _ 
\___ \ / _\` | |/ _ \| '_ \| |/ _\` |
 ___) | (_| | | (_) | | | | | (_| |
|____/ \__,_|_|\___/|_| |_|_|\__,_|
                                   
 __  __       _   _             
|  \/  | __ _| |_| |_ ___  ___  
| |\/| |/ _\` | __| __/ _ \/ _ \ 
| |  | | (_| | |_| ||  __/ (_) |
|_|  |_|\__,_|\__|\__\___|\___/ 's dotfiles

============== INSTALL SCRIPT ==============

"

# Show user available choices
function print_action() {
printf "
$BOLD_ULINE Choose action: $ENDCOL
 1) Install recommended packages (Gentoo)
 2) Install recommended packages (Arch/Artix)
 3) Setup Vim & install Vim plugins
 4) Install recommended fonts (Gentoo)
 5) Install recommended fonts (Arch/Artix)
 6) Install recommended CPU tools (Gentoo)
 7) Install recommended CPU tools (Arch/Artix)
 8) Copy configurations
 9) Build & Install st (suckless terminal)
10) Build & Install dwm (dynamic window manager)
11) Build & Install dmenu
12) Build & Install slock
13) Exit

"
}

# Ask user what to do
function ask_action() {
	read -p "Enter action number: " ACTION

	# Check if input is a valid number
	if [[ ! "$ACTION" =~ ^[0-9]+$ ]]; then
		printf "$REDBG_BOLD[ERROR] The number you entered is not valid! $ENDCOL\n"
		printf "$REDBG_BOLD[ERROR] Make sure you type a number between 1 and 13. $ENDCOL\n"

		# Do we print the dialog above again?
		while true
		do
			read -p " Print action dialog again? [Y/n] " YESNO

			if [[ "$YESNO" =~ ^[yY] ]]; then print_action; break
			else if [[ ! "$YESNO" =~ ^[nN] ]]; then
				printf "[ERROR] Sorry, input not understood."
			else
				break
			fi
			fi

		done

		# Ask action number again, calling ourselves recursively
		ask_action
	fi
}

function __gentoopkgs_pkgs() {
printf "
app-arch/zip
app-editors/neovim
app-misc/neofetch
app-shells/bash
app-shells/bash-completion
app-shells/gentoo-bashcomp
dev-vcs/git
games-misc/fortune-mod
lxde-base/lxappearance
media-gfx/imagemagick
media-gfx/scrot
media-gfx/sxiv
net-misc/curl
sys-apps/mlocate
sys-libs/ncurses
sys-process/cronie
sys-process/htop
x11-libs/libXft
x11-misc/dmenu
x11-misc/dunst
x11-misc/hsetroot
x11-misc/picom
x11-misc/rofi
x11-misc/xdotool
x11-misc/xscreensaver
x11-misc/xsel
x11-misc/xsettingsd
x11-themes/arc-icon-theme
x11-themes/arc-theme
x11-themes/neutral-xcursors
x11-themes/xfwm4-themes
www-client/links

"
}

function __gentoopkgs_print_actions() {
printf "$BOLD_ULINE Choose action: $ENDCOL
1) Print package list
2) Save package list to file
3) Begin installation
4) Exit
"
}

function __gentoopkgs_ask_action() {
	read -p "Enter action number: " GENTOO_ACTION

	# Check if input is a valid number
	if [[ ! "$GENTOO_ACTION" =~ ^[0-9]+$ ]]; then
		printf "$REDBG_BOLD[ERROR] The number you entered is not valid! $ENDCOL\n"
		printf "$REDBG_BOLD[ERROR] Make sure you type a number between 1 and 4. $ENDCOL\n"

		# Do we print the dialog above again?
		while true
		do
			read -p " Print action dialog again? [Y/n] " YESNO

			if [[ "$YESNO" =~ ^[yY] ]]; then __gentoopkgs_print_actions; break
			else if [[ ! "$YESNO" =~ ^[nN] ]]; then
				printf "[ERROR] Sorry, input not understood."
			else
				break
			fi
			fi

		done


		# Ask action number again, calling ourselves recursively
		__gentoopkgs_ask_action
	fi
}

function __gentoopkgs_savetofile() {
	printf "$BLUEBG_BOLD[NOTICE] Saving recommended package list (Gentoo) to gentoo-recommended-pkgs.txt... $ENDCOL\n"
	__gentoopkgs_pkgs > gentoo-recommended-pkgs.txt
}

function install_pkgs_gentoo() {
get_root || main

printf "
  ____            _              
 / ___| ___ _ __ | |_ ___   ___  
| |  _ / _ \ '_ \| __/ _ \ / _ \ 
| |_| |  __/ | | | || (_) | (_) |
 \____|\___|_| |_|\__\___/ \___/ 

$BOLD_ULINE Recommended packages installation $ENDCOL

Please set the appropriate USE flags for the following packages:
"

__gentoopkgs_pkgs

while true; do
	__gentoopkgs_print_actions
	__gentoopkgs_ask_action

	# Parse action
	case "$GENTOO_ACTION" in
		1) __gentoopkgs_pkgs       ;;
		2) __gentoopkgs_savetofile ;;
		3) break                   ;;
		4) main                    ;;
	esac
done

	printf "$BLUEBG_BOLD[NOTICE] Patching libXft... $ENDCOL\n"
	$root wget https://gitlab.freedesktop.org/xorg/lib/libxft/merge_requests/1.patch \
	-O /etc/portage/patches/x11-misc/libXft/libxft-bgra.patch \
	&& printf "$BLUEBG_BOLD[SUCCESS] Successfully patches libXft. $ENDCOL\n" \
	|| printf "$REDBG_BOLD[ERROR] Unable to patch libXft! $ENDCOL\n"

	printf "$BLUEBG_BOLD[NOTICE] Beginning installation: recommended packages (Gentoo) $ENDCOL\n"
	printf "$BLUEBG_BOLD[NOTICE] If there are no reported problems, type 'y' to install packages! $ENDCOL\n"
	printf "$BLUEBG_BOLD[NOTICE] Beginning in 5 seconds. $ENDCOL\n"

	sleep 5

	$root emerge -a app-arch/zip app-editors/neovim app-misc/neofetch app-shells/{bash,bash-completion,gentoo-bashcomp} \
	dev-vcs/git games-misc/fortune-mod lxde-base/lxappearance media-gfx/{imagemagick,scrot,sxiv} net-misc/curl sys-apps/mlocate \
	sys-libs/ncurses sys-process/{cronie,htop} x11-libs/libXft \
	x11-misc/{dmenu,dunst,hsetroot,rofi,picom,xdotool,xscreensaver,xsel,xsettingsd} \
	x11-themes/{arc-icon-theme,arc-theme,neutral-xcursors,xfwm4-themes} www-client/links \
	&& printf "$BLUEBG_BOLD[SUCCESS] Successfully installed recommended packages! $ENDCOL\n" \
	|| printf "$REDBG_BOLD[ERROR] Installation of recommended packages (Gentoo) failed! $ENDCOL\n"
}

function install_pkgs_arch() {
get_root || main

printf "
    _             _        ___         _   _      
   / \   _ __ ___| |__    / / \   _ __| |_(_)_  __
  / _ \ | '__/ __| '_ \  / / _ \ | '__| __| \ \/ /
 / ___ \| | | (__| | | |/ / ___ \| |  | |_| |>  < 
/_/   \_\_|  \___|_| |_/_/_/   \_\_|   \__|_/_/\_\
                                                  
$BOLD_ULINE Recommended packages installation $ENDCOL

"

	printf "$BLUEBG_BOLD[NOTICE] Beginning installation: recommended packages (Arch/Artix) $ENDCOL\n"
	printf "$BLUEBG_BOLD[NOTICE] If there are no reported problems, type 'y' to install packages! $ENDCOL\n"
	printf "$BLUEBG_BOLD[NOTICE] Beginning in 5 seconds. $ENDCOL\n"

	sleep 5

	$root pacman -S base-devel git zip neovim neofetch bash{,-completion} fortune-mod lxappearance imagemagick scrot sxiv curl \
	mlocate ncurses cronie htop dmenu dunst hsetroot rofi picom xdotool xscreensaver xsel xsettingsd \
	arc-icon-theme arc-solid-gtk-theme xfwm4-themes links \
	&& printf "$BLUEBG_BOLD[SUCCESS] Successfully installed recommended packages! $ENDCOL\n" \
	&& printf "Note: Neutral++ cursors have not been installed. Please install the AUR package:\n" \
	&& printf "https://aur.archlinux.org/packages/xcursor-neutral++\n" \
	|| printf "$REDBG_BOLD[ERROR] Installation of recommended packages (Arch/Artix) failed! $ENDCOL\n"

}

function _cp() {
	echo "Copying $@..."
	cp -r ./$1/.[^.]* $HOME
	echo "Done!"
}

function setup_vim() {
printf "
__     ___           
\ \   / (_)_ __ ___  
 \ \ / /| | '_ \` _ \ 
  \ V / | | | | | | |
   \_/  |_|_| |_| |_|
                     
$BOLD_ULINE Setting up vim-plug and installing Vim plugins... $ENDCOL
"
	# Copy vim configurations
	_cp vim

	# Now we can proceed to install vim-plug
	curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \
	&& printf "$BLUEBG_BOLD[SUCCESS] Successfully setup Vim! Please open Vim and run ':PlugInstall' to install plugins. $ENDCOL\n" \
	|| printf "$REDBG_BOLD[ERROR] Could not install plug-vim! $ENDCOL\n"
}

function __gentoofonts_pkgs() {
printf "
media-fonts/fira-code
media-fonts/iosevka
media-fonts/libertine
media-fonts/noto
media-fonts/noto-emoji
media-fonts/powerline-symbols
media-fonts/terminus-font
"
}

function __gentoofonts_print_actions() {
printf "$BOLD_ULINE Choose action: $ENDCOL
1) Print package list
2) Save package list to file
3) Begin installation
4) Exit
"
}

function __gentoofonts_ask_action() {
	read -p "Enter action number: " GENTOO_ACTION

	# Check if input is a valid number
	if [[ ! "$GENTOO_ACTION" =~ ^[0-9]+$ ]]; then
		printf "$REDBG_BOLD[ERROR] The number you entered is not valid! $ENDCOL\n"
		printf "$REDBG_BOLD[ERROR] Make sure you type a number between 1 and 4. $ENDCOL\n"

		# Do we print the dialog above again?
		while true
		do
			read -p " Print action dialog again? [Y/n] " YESNO

			if [[ "$YESNO" =~ ^[yY] ]]; then __gentoofonts_print_actions; break
			else if [[ ! "$YESNO" =~ ^[nN] ]]; then
				printf "[ERROR] Sorry, input not understood."
			else
				break
			fi
			fi

		done


		# Ask action number again, calling ourselves recursively
		__gentoofonts_ask_action
	fi
}

function __gentoofonts_savetofile() {
	printf "$BLUEBG_BOLD[NOTICE] Saving recommended fonts list (Gentoo) to gentoo-recommended-fonts.txt... $ENDCOL\n"
	__gentoofonts_pkgs > gentoo-recommended-fonts.txt
}

function install_fonts_gentoo {
get_root || main

printf "
  ____            _              
 / ___| ___ _ __ | |_ ___   ___  
| |  _ / _ \ '_ \| __/ _ \ / _ \ 
| |_| |  __/ | | | || (_) | (_) |
 \____|\___|_| |_|\__\___/ \___/ 

$BOLD_ULINE Recommended fonts installation $ENDCOL

Please set the appropriate USE flags for the following packages:
"

__gentoofonts_pkgs

while true; do
	__gentoofonts_print_actions
	__gentoofonts_ask_action

	# Parse action
	case "$GENTOO_ACTION" in
		1) __gentoofonts_pkgs       ;;
		2) __gentoofonts_savetofile ;;
		3) break                    ;;
		4) main                     ;;
	esac
done

	printf "$BLUEBG_BOLD[NOTICE] Beginning installation: recommended fonts (Gentoo) $ENDCOL\n"
	printf "$BLUEBG_BOLD[NOTICE] If there are no reported problems, type 'y' to install packages! $ENDCOL\n"
	printf "$BLUEBG_BOLD[NOTICE] Beginning in 5 seconds. $ENDCOL\n"

	sleep 5

	$root emerge -a media-fonts/{fira-code,iosevka,libertine,noto,noto-emoji,powerline-symbols,terminus-font} \
	&& printf "$BLUEBG_BOLD[SUCCESS] Successfully installed recommended fonts! $ENDCOL\n" \
	|| printf "$REDBG_BOLD[ERROR] Installation of recommended fonts (Gentoo) failed! $ENDCOL\n"
}

function install_fonts_arch() {
get_root || main

printf "
    _             _        ___         _   _      
   / \   _ __ ___| |__    / / \   _ __| |_(_)_  __
  / _ \ | '__/ __| '_ \  / / _ \ | '__| __| \ \/ /
 / ___ \| | | (__| | | |/ / ___ \| |  | |_| |>  < 
/_/   \_\_|  \___|_| |_/_/_/   \_\_|   \__|_/_/\_\
                                                  
$BOLD_ULINE Recommended fonts installation $ENDCOL

"

	printf "$BLUEBG_BOLD[NOTICE] Beginning installation: recommended fonts (Arch/Artix) $ENDCOL\n"
	printf "$BLUEBG_BOLD[NOTICE] If there are no reported problems, type 'y' to install packages! $ENDCOL\n"
	printf "$BLUEBG_BOLD[NOTICE] Beginning in 5 seconds. $ENDCOL\n"

	sleep 5

	$root pacman -S ttf-fira-code ttf-iosevka-nerd ttf-linux-libertine noto-fonts noto-fonts-emoji powerline-fonts terminus-font \
	&& printf "$BLUEBG_BOLD[SUCCESS] Successfully installed recommended packages! $ENDCOL\n" \
	&& printf "Note: Neutral++ cursors have not been installed. Please install the AUR package:\n" \
	&& printf "https://aur.archlinux.org/packages/xcursor-neutral++\n" \
	|| printf "$REDBG_BOLD[ERROR] Installation of recommended fonts (Arch/Artix) failed! $ENDCOL\n"
}

function __gentoocputools_pkgs() {
printf "
sys-power/intel-undervolt
sys-power/cpupower
"
}

function __gentoocputools_print_actions() {
printf "$BOLD_ULINE Choose action: $ENDCOL
1) Print package list
2) Save package list to file
3) Begin installation
4) Exit
"
}

function __gentoocputools_ask_action() {
	read -p "Enter action number: " GENTOO_ACTION

	# Check if input is a valid number
	if [[ ! "$GENTOO_ACTION" =~ ^[0-9]+$ ]]; then
		printf "$REDBG_BOLD[ERROR] The number you entered is not valid! $ENDCOL\n"
		printf "$REDBG_BOLD[ERROR] Make sure you type a number between 1 and 4. $ENDCOL\n"

		# Do we print the dialog above again?
		while true
		do
			read -p " Print action dialog again? [Y/n] " YESNO

			if [[ "$YESNO" =~ ^[yY] ]]; then __gentoocputools_print_actions; break
			else if [[ ! "$YESNO" =~ ^[nN] ]]; then
				printf "[ERROR] Sorry, input not understood."
			else
				break
			fi
			fi

		done


		# Ask action number again, calling ourselves recursively
		__gentoocputools_ask_action
	fi
}

function __gentoocputools_savetofile() {
	printf "$BLUEBG_BOLD[NOTICE] Saving CPU tools list (Gentoo) to gentoo-cpu-tools.txt... $ENDCOL\n"
	__gentoocputools_pkgs > gentoo-cpu-tools.txt
}

function install_cputools_gentoo {
get_root || main

printf "
  ____            _              
 / ___| ___ _ __ | |_ ___   ___  
| |  _ / _ \ '_ \| __/ _ \ / _ \ 
| |_| |  __/ | | | || (_) | (_) |
 \____|\___|_| |_|\__\___/ \___/ 

$BOLD_ULINE CPU tools installation $ENDCOL

Please set the appropriate USE flags for the following packages:
"

__gentoocputools_pkgs

while true; do
	__gentoocputools_print_actions
	__gentoocputools_ask_action

	# Parse action
	case "$GENTOO_ACTION" in
		1) __gentoocputools_pkgs       ;;
		2) __gentoocputools_savetofile ;;
		3) break                       ;;
		4) main                        ;;
	esac
done

	printf "$BLUEBG_BOLD[NOTICE] Beginning installation: CPU tools (Gentoo) $ENDCOL\n"
	printf "$BLUEBG_BOLD[NOTICE] If there are no reported problems, type 'y' to install packages! $ENDCOL\n"
	printf "$BLUEBG_BOLD[NOTICE] Beginning in 5 seconds. $ENDCOL\n"

	sleep 5

	$root emerge -a sys-power/{cpupower,intel-undervolt} \
	&& printf "$BLUEBG_BOLD[SUCCESS] Successfully installed CPU tools! $ENDCOL\n" \
	|| printf "$REDBG_BOLD[ERROR] Installation of CPU tools (Gentoo) failed! $ENDCOL\n"

	# Check if we can build x86_energy_perf_policy
	if [ -d "/usr/src/linux/tools/power/x86/x86_energy_perf_policy" ]; then
		printf "$BLUEBG_BOLD Found Kernel directory for x86_energy_perf_policy! Building... $ENDCOL\n"
		LASTDIR=$(pwd)
		cd /usr/src/linux/tools/power/x86/x86_energy_perf_policy
		$root make -j$(nproc) && $root make install \
		|| printf "$REDBG_BOLD[ERROR] Could not build x86_energy_perf_policy! $ENDCOL\n"
		cd $LASTDIR
	else
		printf "$REDBG_BOLD[WARN] Could not find build directory for x86_energy_perf_policy, skipping. $ENDCOL\n"
	fi
}

function install_cputools_arch() {
get_root || main

printf "
    _             _        ___         _   _      
   / \   _ __ ___| |__    / / \   _ __| |_(_)_  __
  / _ \ | '__/ __| '_ \  / / _ \ | '__| __| \ \/ /
 / ___ \| | | (__| | | |/ / ___ \| |  | |_| |>  < 
/_/   \_\_|  \___|_| |_/_/_/   \_\_|   \__|_/_/\_\
                                                  
$BOLD_ULINE CPU tools installation $ENDCOL

"

	printf "$BLUEBG_BOLD[NOTICE] Beginning installation: CPU tools (Arch/Artix) $ENDCOL\n"
	printf "$BLUEBG_BOLD[NOTICE] If there are no reported problems, type 'y' to install packages! $ENDCOL\n"
	printf "$BLUEBG_BOLD[NOTICE] Beginning in 5 seconds. $ENDCOL\n"

	sleep 5

	$root pacman -S cpupower intel-undervolt x86_energy_perf_policy \
	&& printf "$BLUEBG_BOLD[SUCCESS] Successfully installed CPU tools! $ENDCOL\n" \
	|| printf "$REDBG_BOLD[ERROR] Installation of CPU tools (Arch/Artix) failed! $ENDCOL\n"
}

function __config_print_actions() {
printf "
$BOLD_ULINE Choose which configuration to copy: $ENDCOL
 1) Copy all configurations
 2) Audacious
 3) Bash (aliases, bashrc, inputrc)
 4) Dunst
 5) Fontconfig
 6) GPG
 7) GTK (dconf)
 8) Htop
 9) Neofetch
10) nnn
11) Picom
12) Rofi
13) Vim
14) X.org (xinitrc + XFCE, xinitrc + dwm, Xresources, xscreensaver)
15) Copy scripts (dwmblocks scripts & misc scripts)
16) Copy wallpapers
17) Exit

"
}

function __config_ask_action() {
	read -p "Enter action number: " CONFIG_ACTION

	# Check if input is a valid number
	if [[ ! "$ACTION" =~ ^[0-9]+$ ]]; then
		printf "$REDBG_BOLD[ERROR] The number you entered is not valid! $ENDCOL\n"
		printf "$REDBG_BOLD[ERROR] Make sure you type a number between 1 and 17. $ENDCOL\n"

		# Do we print the dialog above again?
		while true
		do
			read -p " Print action dialog again? [Y/n] " YESNO

			if [[ "$YESNO" =~ ^[yY] ]]; then print_action; break
			else if [[ ! "$YESNO" =~ ^[nN] ]]; then
				printf "[ERROR] Sorry, input not understood."
			else
				break
			fi
			fi

		done

		# Ask action number again, calling ourselves recursively
		__config_ask_action
	fi
}

function config_menu() {
while true; do
	__config_print_actions
	__config_ask_action

	# Parse action
	case "$CONFIG_ACTION" in
		 1) for f in audacious bash dunst fontconfig gpg dconf htop neofetch nnn picom rofi scripts vim wallpapers X; do _cp $f; done ;;
		 2) _cp audacious  ;;
		 3)
			 _cp bash;

			 # Check if repo already exists
			if [[ -d "$HOME/software/ble.sh" ]]; then
				printf "$BLUEBG_BOLD[NOTICE] Skipping git clone, already have repo...$ENDCOL\n" \
				&& LASTDIR="$(pwd)"
			else
				printf "$BLUEBG_BOLD[NOTICE] Cloning git repo...$ENDCOL\n" \
				&& LASTDIR="$(pwd)" \
				&& mkdir -p $HOME/software && cd $HOME/software \
				&& git clone --recursive --depth=1 https://github.com/akinomyoga/ble.sh \
				|| printf "$REDBG_BOLD[ERROR] Could not clone git repo! $ENDCOL\n"
			fi

			# Continue if repo exists
			if [[ -d "ble.sh" ]]; then
				printf "$BLUEBG_BOLD[NOTICE] Installing BLE.sh...$ENDCOL\n" \
				&& make -j$(nproc) -C ble.sh install PREFIX=~/.local && cd $LASTDIR \
				&& printf "$BLUEBG_BOLD[SUCCESS] Successfully installed BLE.sh. $ENDCOL\n" \
				|| printf "$REDBG_BOLD[ERROR] Could not build/install BLE.sh! $ENDCOL\n"
			fi

			 ;;
		 4) _cp dunst      ;;
		 5) _cp fontconfig ;;
		 6) _cp gpg        ;;
		 7) _cp dconf      ;;
		 8) _cp htop       ;;
		 9) _cp neofetch   ;;
		10) _cp nnn        ;;
		11) _cp picom      ;;
		12) _cp rofi       ;;
		13) _cp vim        ;;
		14) _cp X          ;;
		15) _cp scripts    ;;
		16) _cp wallpapers ;;
		17) break            ;;
		*) printf "Action numbers must go from 1 to 17!\n"; __config_ask_action ;;
	esac
done
}

function setup_st() {
get_root || main

printf "
     _   
 ___| |_ 
/ __| __|
\__ \ |_ 
|___/\__|
         
$BOLD_ULINE Build & Install st (suckless terminal) $ENDCOL

"

	# Clone repository
	git clone "https://github.com/saloniamatteo/st" &&

	# Build & Install st
	make -j$(nproc) && $root make install \
	&& printf "$BLUEBG_BOLD[SUCCESS] Successfully installed st. $ENDCOL\n" \
	|| printf "$REDBG_BOLD[ERROR] Could not build/install st! $ENDCOL\n"
}

function setup_dwm() {
get_root || main

printf "
     _                    
  __| |_      ___ __ ___  
 / _\` \ \ /\ / / '_ \` _ \ 
| (_| |\ V  V /| | | | | |
 \__,_| \_/\_/ |_| |_| |_|
                          
$BOLD_ULINE Build & Install dwm (dynamic window manager) $ENDCOL

"

	# Build & Install dwm
	cd dwm && make clean && make -j$(nproc) && $root make install \
	&& printf "$BLUEBG_BOLD[SUCCESS] Successfully installed dwm. $ENDCOL\n" \
	&& cd dwmblocks && make clean && make && $root make install \
	&& printf "$BLUEBG_BOLD[SUCCESS] Successfully installed dwmblocks. $ENDCOL\n" \
	|| printf "$REDBG_BOLD[ERROR] Could not build/install dwm/dwmblocks! $ENDCOL\n"
}

function setup_dmenu() {
get_root || main

printf "
     _                            
  __| |_ __ ___   ___ _ __  _   _ 
 / _\` | '_ \` _ \ / _ \ '_ \| | | |
| (_| | | | | | |  __/ | | | |_| |
 \__,_|_| |_| |_|\___|_| |_|\__,_|

$BOLD_ULINE Build & Install dmenu $ENDCOL

"

	# Clone repository
	git clone https://github.com/lukesmithxyz/dmenu
	cd dmenu
	make -j$(nproc) && $root make install \
	&& printf "$BLUEBG_BOLD[SUCCESS] Successfully installed dmenu. $ENDCOL\n" \
	|| printf "$REDBG_BOLD[ERROR] Could not build/install dmenu! $ENDCOL\n"
}

function setup_slock() {
get_root || main

printf "
     _            _    
 ___| | ___   ___| | __
/ __| |/ _ \ / __| |/ /
\__ \ | (_) | (__|   < 
|___/_|\___/ \___|_|\_\
                       
$BOLD_ULINE Build & Install slock $ENDCOL

"

	cd slock
	make -j$(nproc) && $root make install \
	&& printf "$BLUEBG_BOLD[SUCCESS] Successfully installed slock. $ENDCOL\n" \
	|| printf "$REDBG_BOLD[ERROR] Could not build/install slock! $ENDCOL\n"
}

function main() {
while true; do
	print_action
	ask_action

	# Parse action
	case "$ACTION" in
		1)  install_pkgs_gentoo     ;;
		2)  install_pkgs_arch       ;;
		3)  setup_vim               ;;
		4)  install_fonts_gentoo    ;;
		5)  install_fonts_arch      ;;
		6)  install_cputools_gentoo ;;
		7)  install_cputools_arch   ;;
		8)  config_menu             ;;
		9)  setup_st                ;;
		10) setup_dwm               ;;
		11) setup_dmenu             ;;
		12) setup_slock             ;;
		13) exit 0                  ;;
		*) printf "Action numbers must go from 1 to 13!\n"; ask_action ;;
	esac
done
}

main
