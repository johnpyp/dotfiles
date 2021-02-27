#!/bin/sh

$HOME/.scripts/flat-mice
xset r rate 200 100
setxkbmap -option 'caps:escape, altwin:swap_alt_win' -layout us
/usr/lib/xfce4/notifyd/xfce4-notifyd &
# dunst -config $HOME/.config/dunst/dunstrc-dark-right
