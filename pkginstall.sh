#!/bin/bash
read -p "Are you sure? [Y/n]" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
	echo "confirmed"
	INSTALLED=$(sort <(yay -Qqe))
	INSTALL_LIST=$(sort pkglist.txt)
	TO_INSTALL=$(comm -13 <(echo "$INSTALLED") <(echo "$INSTALL_LIST")) 
	echo $TO_INSTALL
fi



