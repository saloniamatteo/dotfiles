# Set renderer to GPU
xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto

# Load ICC profile
xcalib Downloads/Lenovo_ThinkPad_T470p_B140QAN01_5.icm

# Window scaling
export QT_AUTO_SCREEN_SET_FACTOR=0
export QT_SCALE_FACTOR=1
export QT_FONT_DPI=192
export GDK_SCALE=2
export GDK_DPI_SCALE=0.5

# X settings
setxkbmap it							# Set X keyboard layout to "it"
xset r rate 250 50						# Increase keyboard speed
xset m 1 1								# Mouse acceleration
xset dpms 600							# Display Power Management Signaling
xrdb -merge ~/.Xresources 				# Load Xresouces

# Status bar & applets
dwmblocks &								# DWM Status bar
dunst &									# Notification daemon
copyq &									# Clipboard
nm-applet &								# NetworkManager applet
gentoo-pipewire-launcher &				# Start pipewire

# Misc
v4l2-ctl --set-ctrl brightness=50 &		# Set webcam brightness
hsetroot -cover Pictures/e60_3.jpg &	# Set wallpaper
unclutter -idle 3 -jitter 25x25 -grab &	# Hide the mouse automatically if it's not being used
picom -b &								# Transparency

# Run dwm
exec dbus-launch --exit-with-session /usr/local/bin/dwm
