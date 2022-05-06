# Salonia Matteo's dotfiles
## Sections:
- [Donate](#donate)
- [Cloning note](#cloning-note)
- [Installation](#installation)
- [Previews](#previews)
- [Help](#help)
- [Others (not included)](#others-not-included)
	- [LibreWolf Addons](#librewolf-addons)
- [Terminal](#terminal)
	- [Shell](#shell)
- [Window Manager](#window-manager)
	- [Slock (suckless locker)](#slock)
- [Intel Undervolt](#intel-undervolt)
- [Low Battery Notifier](#low-battery-notifier)

***

## Donate
Support this project: https://saloniamatteo.top/donate.html

## Cloning note
NOTE! Please clone this repository with the following command:
`git clone --recurse-submodules https://github.com/saloniamatteo/dotfiles`

The directory `dwm` is a submodule that points to
[saloniamatteo/dwm](https://github.com/saloniamatteo/dwm)
and might not get downloaded when cloning normally!

## Installation
A script to install various components is included.
You can choose which component to install, and the script will help you.

**NOTE**: If you want to install packages, you can only choose `pacman` or `portage`
(aka Arch or Gentoo); install packages yourself if you don't have installed them already.

**NOTE 2**: When installing packages on Gentoo, the script will first ask you to
configure your USE flags (you will be able to proceed to install the
packages anytime you please, even if you don't change your USE flags)

To run the all-in-one script, run the following commands:

```bash
git clone --recurse-submodules https://github.com/saloniamatteo/dotfiles
cd dotfiles
./install.sh
```

## Previews (dwm configuration)

See [saloniamatteo/dwm#previews](https://github.com/saloniamatteo/dwm#previews) for more pictures.

Tiling st window with zsh prompt
![st-tile](https://raw.githubusercontent.com/saloniamatteo/dwm/master/Previews/preview-st.png)

Tiling st window with floating program
![tile-float](https://raw.githubusercontent.com/saloniamatteo/dwm/master/Previews/preview-floating-win.png)

Tiling layout (programs: `ranger`, `nvim`, and `tty-clock`)
![layout-tile](https://raw.githubusercontent.com/saloniamatteo/dwm/master/Previews/layouts-tile.png)

CenteredMaster layout (programs: `neofetch`, `ranger` and `htop`)
![layout-centeredmaster](https://raw.githubusercontent.com/saloniamatteo/dwm/master/Previews/layouts-centeredmaster.png)

***

## Help
Have any issues with dwm? Check the [`man` page](https://github.com/saloniamatteo/dwm/blob/master/dwm.1)
or read the [source code](https://github.com/saloniamatteo/dwm/blob/master/config.h),
it contains all of the custom keybindings that I use with dwm.

NOTE: [saloniamatteo/dwm](https://github.com/saloniamatteo/dwm) is the main repository
for my build of dwm & dwmblocks. If you need any help, go there.

## Others (not included)
- Browser: [LibreWolf](https://librewolf.net)
- Grub theme: [Gentoo Silence](https://github.com/saloniamatteo/gentoo-silence), [Artix Silence](https://aur.archlinux.org/packages/artix-silence-grub-theme-git)
- GTK dark theme: [matcha-dark-azul](https://github.com/vinceliuice/matcha-gtk-theme)
- Icon theme: [Arc](https://github.com/horst3180/arc-icon-theme)
- Simple MTP device manager (mount android devices): [`simple-mtpfs`](https://wiki.archlinux.org/index.php/Media_Transfer_Protocol#simple-mtpfs)
- Ncurses disk usage utility: [`ncdu`](https://dev.yorhel.nl/ncdu)

NOTE: If you want to change GTK's graphical settings on dwm,
such as the cursor theme or the icon theme, use a program like `lxappearance`.

### Firefox (LibreWolf) addons
Here's a list of the Firefox addons I use:
- Age restriction bypass for YouTube
- Amazon Container
- CanvasBlocker
- ClearURLs
- Facebook Container
- Google Container - with Integrations
- Greasemonkey
- Return YouTube dislike
- SponsorBlock for YouTube
- Temporary containers
- Twitter Container
- uBlock Origin
- Universal Bypass

## Terminal
- Terminal: `st` ([My build](https://github.com/saloniamatteo/st))
- Terminal file manager: `nnn`
- Get system info: `neofetch`

***

## Window Manager
- Window Manager: `dwm`
- Status bar: `dwmblocks` 
- Lock screen: `slock` 

### Slock
I have included my own build of [slock](https://tools.suckless.org/slock) with two patches:

- Caps color: turns the screen bright red to alert the user that caps lock is on
- Message: include a custom message; with my custom build you can see when the screen was locked & a random quote, using `fortune`.

To install Slock, run:

```bash
cd slock &&
sudo make clean install
```

Another build of mine, called `slock-red` is included.
This build has its background color always set to red.

***

### Intel Undervolt

#### READ CAREFULLY!

I have a ThinkPad T440p with an Intel Core i5-4340M (Haswell). I have installed a tool that undervolts the CPU. `intel-undervolt`'s configuration file is located over at `/etc/intel-undervolt.conf`. My config file can be found in the root of this repository and is not copied over by default for security reasons. You have to be careful with undervolting, so read the following info ***CAREFULLY***!

- Values over -60mV are considered ***UNSAFE***, unless you know what you are doing!
- You know when you undervolted too much when the screen starts flickering, or you cannot perform any benchmark (either graphical benchmarks that involve the iGPU/GPU, or benchmarks that involve the CPU)
- Generally, undervolting is safer than overclocking

I have found that the best performance obtainable by my laptop was achieved by
undervolting with`intel-undervolt`,
setting the CPU governor to "performance",
increasing the fan speed to 7/max (use the command `.config/scripts/set-fan` included with my dotfiles
or use this helpful utility that comes with a GUI: [tp-xfan](https://github.com/saloniamatteo/tp-xfan)),
and using the power supply instead of the battery

I do not condone undervolting. Do it at your own risk.

***

### Low battery notifier
I wrote my own low battery notifier. If one of your batteries' capacity is less than 20%, it will send a critical notification, containing said battery name and its capacity. To make this work, you need to install a cron manager. (I use `cronie`)

After you're done, run this command: `crontab -e`, then add these two lines
(assuming $UID is `1000`, which should be the first user you create, apart from root):

```
# if the user's battery's percentage is <20% and it is not charging, warn the user
* * * * * DISPLAY=:0 XDG_RUNTIME_DIR=/run/user/1000 ~/.config/scripts/bat-warn
```

You're done! I also have this in my root crontab:

`*/30 * * * * /usr/bin/updatedb`

Every 30 minutes the command `updatedb` will run, so that the next time you run `locate FILE` it will be very fast to show you where a file is.

***
