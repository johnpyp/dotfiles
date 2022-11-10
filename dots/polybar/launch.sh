#!/usr/bin/env bash

echo "Test"
# Terminate already running bar instances

pkill polybar
export DEFAULT_NETWORK_INTERFACE=$(ls /sys/class/net | grep wlp | head -n 1 | awk '{print $1}')
# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

IFS=$'\n'  # must set internal field separator to avoid dumb (iterating over xrandr query would bork out otherwise)

PRIMARY_MONITOR=$(xrandr --query | grep " connected" | cut -d" " -f1 | head -n 1)


for entry in $(xrandr --query | grep " connected"); do                         
  echo "$entry"
  mon=$(cut -d" " -f1 <<< "$entry")                                          
  status=$(cut -d" " -f3 <<< "$entry")                                       
                                                                             
  if [ "$status" == "primary" ]; then                                        
      echo "$entry - $mon - $status"
      PRIMARY_MONITOR=$mon
  fi                                                                         
done

network_interface=$(ip -4 route ls | grep default | grep -Po '(?<=dev )(\S+)')

outputs=$(xrandr --query | grep " connected" | cut -d" " -f1)
for m in $outputs; do
  export MONITOR=$m
  export TRAY_POSITION=none
  export NETWORK_INTERFACE=$network_interface
  if [[ "$m" == "$PRIMARY_MONITOR" ]]; then
    export TRAY_POSITION=right
  fi

  echo 
  echo "${PRIMARY_MONITOR} - ${MONITOR} - ${TRAY_POSITION} - ${NETWORK_INTERFACE}"
  printf "$MONITOR - $TRAY_POSITION - $NETWORK_INTERFACE"

  polybar -r top 2>&1 | tee -a /tmp/polybar-monitor-"$mon".log & disown
done
