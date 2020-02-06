
#!/bin/sh

# Terminate already running bar instances
pkill polybar
export DEFAULT_NETWORK_INTERFACE=$(ls /sys/class/net | grep wlp | head -n 1 | awk '{print $1}')
# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
outputs=$(xrandr --query | grep " connected" | cut -d" " -f1)
tray_output="eDP-1"

for m in $outputs; do
  if [[ $m == "DVI-D-0" ]]; then
      tray_output=$m
  fi
done

for m in $outputs; do
  export MONITOR=$m
  export TRAY_POSITION=none
  if [[ $m == $tray_output ]]; then
    export TRAY_POSITION=right
  fi
  polybar --reload top &
  disown
done
