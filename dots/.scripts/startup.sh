#!/bin/sh

$HOME/dotfiles/scripts/flat-mice
xset r rate 200 100
setxkbmap -option 'caps:escape, compose:ralt, altwin:swap_alt_win' -layout us
