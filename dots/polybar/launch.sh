
#!/bin/sh

# Terminate already running bar instances
killall -q polybar
export DEFAULT_NETWORK_INTERFACE=$(ls /sys/class/net | grep wlp | head -n 1 | awk '{print $1}')
# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

for m in $(polybar --list-monitors | cut -d":" -f1); do
    MONITOR=$m polybar --reload top &
done
