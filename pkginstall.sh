#!/bin/bash
INSTALLED=$(sort <(yay -Qq))
INSTALL_LIST=$(sort pkglist.txt)
TO_INSTALL=$(comm -13 <(echo "$INSTALLED") <(echo "$INSTALL_LIST"))
echo $TO_INSTALL
