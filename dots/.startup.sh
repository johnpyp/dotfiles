# Launch network manager applet
nm-applet &
xfce4-power-manager &
xfce4-clipman &

# Launch polybar
$HOME/.config/polybar/launch.sh &
# Set background
feh --bg-fill $HOME/.config/wallpapers/current.jpg &
# Set keyrepeat and delay
xset r rate 250 80
# Start autolock
xautolock -time 20 -locker "betterlockscreen -l dimblur" &
# Start prefered notification daaemon
killall dunst; /usr/lib/xfce4/notifyd/xfce4-notifyd &

sleep 1
compton -b &
# Bind compose key to right-alt
setxkbmap -option compose:ralt &
