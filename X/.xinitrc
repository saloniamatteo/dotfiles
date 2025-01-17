# Set renderer to GPU
# Comment if not using an nvidia GPU
xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto

# Load ICC profile
# Comment if not using a custom ICC profile
xcalib Downloads/Lenovo_ThinkPad_T470p_B140QAN01_5.icm

# Window scaling
# These values are set for a 2560x1440 display
export QT_AUTO_SCREEN_SET_FACTOR=0
export QT_SCALE_FACTOR=1
export QT_FONT_DPI=192				# Change to 96 for a smaller screen
#export GDK_SCALE=2					# GTK window scaling. NOTE: GTK does not
#export GDK_DPI_SCALE=1				# directly support fractional scaling

# X settings
setxkbmap it						# Set X keyboard layout to "it"
xset r rate 250 50					# Increase keyboard speed
xset m 1 1							# Mouse acceleration
xset s off							# Disable screen saver
xset +dpms							# Enable DPMS (Display Power Management Signaling)
xset dpms 600 600 600				# Set standby, suspend, and off times to 10 minutes
xrdb -merge ~/.Xresources			# Load Xresouces

# Status bar & applets
gentoo-pipewire-launcher restart &	# Start pipewire
copyq &								# Clipboard
nm-applet &							# NetworkManager applet
blueman-applet &					# Bluetooth applet
dwmblocks &							# DWM Status bar
dunst &								# Notification daemon

# Misc
v4l2-ctl --set-ctrl brightness=100 &	# Set webcam brightness
hsetroot -cover Pictures/e60/e60_3.jpg	# Set wallpaper
unclutter -idle 3 -jitter 25x25 -grab &	# Hide the mouse automatically if it's not being used
picom -b &# Transparency

# Run dwm
exec dbus-launch --exit-with-session dwm

# Run KDE plasma
#exec dbus-launch --exit-with-session startplasma-x11
