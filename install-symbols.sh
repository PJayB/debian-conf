#!/bin/bash
SYMBOLPACKAGES=
LIBSTOFIND=$1
if [[ "$LIBSTOFIND" == "" ]]; then
	echo "Usage: $0 <library or binary name>"
	exit 1
fi
for pkg in "$LIBSTOFIND"; do
	FOUNDPACKAGES=$(dpkg -S $pkg | grep -o -E "[a-zA-Z0-9_.-]+:[a-zA-Z0-9_.-]+")
	#FOUNDPACKAGES=$(apt list --installed | grep -o -e "^[^/]*$pkg[^/]*")
	if [[ "$FOUNDPACKAGES" == "" ]]; then
		echo "No packages found matching file pattern $pkg"
		exit 1
	fi
	for i in $FOUNDPACKAGES; do
		PACKAGENAME=$(echo $i | grep -o -E "^[^:]+")
		PACKAGEARCH=$(echo $i | grep -o -E ":.*$")
		SYMBOLPKG=$PACKAGENAME-dbgsym
		SYMBOL=$(apt-cache search $SYMBOLPKG)
		if [[ "$SYMBOL" != "" ]]; then
			echo "Symbols for $i -> $SYMBOL"
			SYMBOLPACKAGES=$(echo $SYMBOLPACKAGES $SYMBOLPKG$PACKAGEARCH)
		else
			echo "Symbols for $PACKAGENAME$PACKAGEARCH not found."
		fi
	done
done
if [[ "$SYMBOLPACKAGES" != "" ]]; then
	echo "Installing symbols for $SYMBOLPACKAGES"
	sudo apt install $SYMBOLPACKAGES
fi


