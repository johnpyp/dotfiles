#!/bin/sh

if [ "$(pgrep -a openvpn$)" ]; then
    exit 0
else
    exit 1
fi
