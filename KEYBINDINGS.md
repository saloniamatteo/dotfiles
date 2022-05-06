# i3wm keybindings
PLEASE NOTE: the <kbd>SUPER</kbd> key is also known as the ["Windows" key](https://upload.wikimedia.org/wikipedia/commons/3/3c/Touche_Windows_8_10.jpg).

## Terminal keybindings
<kbd>ALT</kbd>+<kbd>ENTER</kbd>: open the suckless terminal (st)

<kbd>ALT</kbd>+<kbd>SHIFT</kbd>+<kbd>ENTER</kbd>: open the kitty terminal

<kbd>CTRL</kbd>+<kbd>SHIFT</kbd>+T: open a new kitty terminal tab

<kbd>CTRL</kbd>+<kbd>SHIFT</kbd>+[Left/Right]: browse kitty terminal tabs

<kbd>CTRL</kbd>+D: close the current tab if there is an empty line

## Menu keybindings
<kbd>ALT</kbd>+D: open rofi to launch an application/a command

<kbd>ALT</kbd>+<kbd>SHIFT</kbd>+D: open dmenu (same as rofi)

<kbd>ALT</kbd>+<kbd>SHIFT</kbd>+W: open firefox

<kbd>SUPER</kbd>+B: create a new blank window (like dwm)

<kbd>SUPER</kbd>+D: Select a display

<kbd>SUPER</kbd>+I: move the mouse automatically to prevent inactivity

<kbd>SUPER</kbd>+M: open dmenu to show mountable drives

<kbd>SUPER</kbd>+N: choose a network connection

<kbd>SUPER</kbd>+<kbd>SHIFT</kbd>+E: emoji selector

<kbd>SUPER</kbd>+<kbd>SHIFT</kbd>+U: Monitor a disk's usage

<kbd>SUPER</kbd>+U: open dmenu to show unmountable drives

<kbd>SUPER</kbd>+W: set a new random wallpaper

## Window keybindings
### Window borders
<kbd>ALT</kbd>+F4: close the current window

<kbd>ALT</kbd>+F: enter fullscreen mode

<kbd>ALT</kbd>+N: set the window border to normal

<kbd>ALT</kbd>+U: hide the window borders

<kbd>ALT</kbd>+Y: set the window border to 3 pixels

<kbd>SUPER</kbd>+E: toggle the window split (for example from horizontal to vertical)

<kbd>SUPER</kbd>+H: split focused window horizontally

<kbd>SUPER</kbd>+V: split focused window vertically

### Gaps
<kbd>ALT</kbd>+X: decrease gaps

<kbd>ALT</kbd>+Z: increase gaps

<kbd>SUPER</kbd>+G: toggle gaps (enable/disable)

### Change focus
<kbd>ALT</kbd>+[h/Left]: change window focus to left

<kbd>ALT</kbd>+[j/Down]: change window focus to down

<kbd>ALT</kbd>+[k/Up]: change window focus to up

<kbd>ALT</kbd>+[l/Right]: change window focus to right

### Move focused window
<kbd>ALT</kbd>+<kbd>SHIFT</kbd>+[h/Left]: move focused window left

<kbd>ALT</kbd>+<kbd>SHIFT</kbd>+[j/Down]: move focused window down

<kbd>ALT</kbd>+<kbd>SHIFT</kbd>+[k/Up]: move focused window up

<kbd>ALT</kbd>+<kbd>SHIFT</kbd>+[l/Right]: move focused window right

### Window style
<kbd>ALT</kbd>+S: set focused window style to stacking

<kbd>ALT</kbd>+W: set focused window style to tabbed

<kbd>ALT</kbd>+<kbd>SHIFT</kbd>+SPACE: toggle between floating or tiling

### Moving and resizing windows
<kbd>ALT</kbd>+R: enter resize mode (while in resize mode, resize the window either with hjkl or with the arrow keys)

<kbd>ALT</kbd>+[Mouse right]: resize a window with the mouse cursor

<kbd>ALT</kbd>+[Mouse move]: move a window

<kbd>ALT</kbd>+<kbd>SHIFT</kbd>+[h/j/k/l]: move window

<kbd>ALT</kbd>+<kbd>SHIFT</kbd>+[Arrow keys]: move window

## Workspaces
<kbd>ALT</kbd>+[1/2/3...]: change workspace

<kbd>ALT</kbd>+<kbd>SHIFT</kbd>+[1/2/3...]: move focused window to workspace

## Screenshots
PRINTSCR: take a screenshot, move it to `~/Pictures` and preview it

## Locking & Logging out
<kbd>SUPER</kbd>+L: lock i3 using i3locker

<kbd>SUPER</kbd>+<kbd>SHIFT</kbd>+L: end X session and go back to LightDM

## Special/Function keys
You can use the special Function keys with the appropriate icon to run the according commands. On some laptops you might have to press the "Fn" button to use these special keys. Down below are listed the keybindings I have, they might be different for you. (I have a Thinkpad T440p)

+ Volume:
	- (XF86AudioRaiseVolume) F1: mute
	- (XF86AudioLowerVolume) F2: decrease
	- (XF86AudioMute) F3: increase
	- (XF86AudioMicMute) F4: toggle microphone (enable/disable)

+ Brightness:
	- (XF86MonBrightnessUp)	F5: decrease
	- (XF86MonBrightnessDown) F6: increase

+ Network:
	- F8: toggle wifi (enable/disable)

+ Webcam:
	- (XF86Display) F7: toggle webcam (enable/disable)
	- (XF86Explorer) F12: fix webcam

+ Others:
	- (XF86Tools) F9: cpu toolkit
	- (XF86Search) F10: download videos from YT
	- (XF86LaunchA) F11: choose which scripts to launch

+ Assigned (but not used) keybindings for mpc:
	- XF86AudioNext: next song
	- XF86AudioPrev: previous song
	- XF86AudioPlay: play/pause song
	- XF86AudioStop: stop song

## i3wm
<kbd>ALT</kbd>+<kbd>SHIFT</kbd>+C: reload the i3wm config file

<kbd>ALT</kbd>+<kbd>SHIFT</kbd>+R: reload i3wm
