#!/bin/bash
PACKAGES=$(apt list --installed | grep -o -e "^[^/]*$1[^/]*")
#PACKAGES=$(apt list --installed | grep -o -e "^.*$1.*/")
if [[ "$PACKAGES" == "" ]]; then
	echo "No packages found matching $1"
	exit 1
fi
#IFS=$'\n'
SYMBOLPACKAGES=
for i in $PACKAGES; do
	SYMBOLPKG=$i-dbgsym
	SYMBOL=$(apt-cache search $SYMBOLPKG)
	if [[ "$SYMBOL" != "" ]]; then
		echo "Symbols for $i -> $SYMBOL"
		SYMBOLPACKAGES=$(echo $SYMBOLPACKAGES $SYMBOLPKG)
	else
		echo "Symbols for $i not found."
	fi
done
if [[ "$SYMBOLPACKAGES" != "" ]]; then
	echo "Installing symbols for $SYMBOLPACKAGES"
	sudo apt install $SYMBOLPACKAGES
fi


