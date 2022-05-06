setxkbmap it						# Set X keyboard layout to "it"
xset r rate 400 50					# Increase keyboard speed
xset dpms 600						# Energy star
unclutter -idle 3 -jitter 25x25 -grab &			# Hide the mouse automatically if it's not being used
xrdb -merge ~/.Xresources 				# Load Xresouces
pulseaudio &						# Start Pulseaudio
picom -b &						# Transparency
connman-gtk --tray &					# Connection Manager GUI

# Automatically lock the screen if not used for more than 10 minutes
#xautolock -time 10 -detectsleep -locker 'slock -m "Locked at $(date "+%a %d, %H:%M:%S") $(printf "\nRandom quote: \n") $(fortune)"' &
#xscreensaver -no-splash &

# Adjust speaker sound levels
amixer -qD pulse sset Master 60% &
amixer -qD pulse sset Master mute &

# Adjust microphone sound levels
amixer -qD pulse sset Capture 60% &
amixer -qD pulse sset Capture mute &

# Set webcam brightness
v4l2-ctl --set-ctrl brightness=50 &

# Run XFCE4
startxfce4
