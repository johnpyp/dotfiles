#!/bin/sh

a=$(ls -l /sys/class/backlight | wc -l)
if [ "$a" -gt 0 ]; then
  exit 0
else
  exit 1
fi
