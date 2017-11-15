#!/bin/bash
SYMBOLPACKAGES=
LIBSTOFIND=$@
if [[ "$LIBSTOFIND" == "" ]]; then
	echo "Usage: $0 <library or binary name>" >&2
	exit 1
fi
for pkg in $LIBSTOFIND; do
#	echo "Searching for packages matching '$pkg'..."
	ALLPACKAGES=$(dpkg -S $pkg)
#	(IFS=$'\n'; for i in $ALLPACKAGES; do echo " ... $i"; done)
	FOUNDPACKAGES=$(echo $ALLPACKAGES | grep -o -E "[a-zA-Z0-9_.-]+:[a-zA-Z0-9_.-]+")
	#FOUNDPACKAGES=$(apt list --installed | grep -o -e "^[^/]*$pkg[^/]*")
	if [[ "$FOUNDPACKAGES" == "" ]]; then
		echo "No packages found matching file pattern $pkg" >&2
		exit 1
	fi
	for i in $FOUNDPACKAGES; do
		PACKAGENAME=$(echo $i | grep -o -E "^[^:]+")
		PACKAGEARCH=$(echo $i | grep -o -E ":.*$")
		PACKAGESYMBOLS=
		for dbgtype in dbg dbgsym; do
			SYMBOLPKG=$PACKAGENAME-$dbgtype
#			echo "Looking for $SYMBOLPKG"
			SYMBOL=$(apt-cache search $SYMBOLPKG)
			if [[ "$SYMBOL" != "" ]]; then
#				echo "Symbols for $i -> $SYMBOL"
				PACKAGESYMBOLS=$(echo $PACKAGESYMBOLS $SYMBOLPKG$PACKAGEARCH)
			fi
		done
		if [[ "$PACKAGESYMBOLS" == "" ]]; then
			echo "Symbols for $PACKAGENAME$PACKAGEARCH not found." >&2
			exit 1
		else
			SYMBOLPACKAGES=$(echo $SYMBOLPACKAGES $PACKAGESYMBOLS)
		fi
	done
done
#if [[ "$SYMBOLPACKAGES" != "" ]]; then
#	echo "Installing symbols for $SYMBOLPACKAGES"
#	echo sudo apt install $SYMBOLPACKAGES
#fi
echo $SYMBOLPACKAGES



