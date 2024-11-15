## Donate
Support this project: [salonia.it/donate](https://salonia.it/donate)

## Installation
Previously, I had a script to do various actions, both for Arch Linux and Gentoo.

That script has now been removed, since it is impossible to keep up with it,
and the many configurations this repo has.

In order to copy a component to your system, you can just copy
the contents of the chosen directory to your $HOME directory:
the appropriate files will go where they need to go.

`cd` into any "module"'s directory, and look at
its contents with `tree -a`.

Please make sure you review every file before overwriting your configs.

## dwm & dwmblocks
This repo no longer contains the `dwm` submodule, since that would
only be endless recursion.
Instead, take a look at https://github.com/saloniamatteo/dwm

## Themes
- Grub theme: [Gentoo Silence](https://github.com/saloniamatteo/gentoo-silence)
- GTK theme: [Breeze](https://github.com/KDE/breeze)
- Icon theme: [Tela](https://github.com/vinceliuice/Tela-icon-theme)

NOTE: If you want to change GTK's graphical settings on dwm,
such as the cursor theme or the icon theme, use a program like `lxappearance`.

## Firefox (LibreWolf) addons
Here's a list of the Firefox addons I use:
- ClearURLs
- Return YouTube dislike
- SponsorBlock
- Temporary containers
- uBlock Origin
- Universal Bypass (now FastForward)

## Window Manager
- Window Manager: [dwm](https://dwm.suckless.org)
- Status bar: [dwmblocks](https://github.com/torrinfail/dwmblocks)
- Lock screen: [slock](https://tools.suckless.org/slock)

## Intel Undervolt
### READ CAREFULLY!
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

I do not recommend undervolting, unless you know what you're doing. Do it at your own risk.

## Low battery notifier
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
