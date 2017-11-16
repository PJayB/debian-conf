#!/bin/bash
SYMBOLPACKAGES=
MISSINGPACKAGES=
LIBSTOFIND=$@
OUTPUT=/dev/stderr
INSTALLEDPACKAGES=$(apt list --installed)
if [[ "$LIBSTOFIND" == "" ]]; then
	echo "Usage: $0 <library or binary name>" >&2
	exit 1
fi
for pkg in $LIBSTOFIND; do
	echo "Searching for packages matching '$pkg'..." > $OUTPUT
	ALLPACKAGES=$(dpkg -OS $pkg)
	FOUNDPACKAGES=$(echo $ALLPACKAGES | grep -o -E "[a-zA-Z0-9_.:-]+[:,] " | sort -u)
	(IFS=$'\n'; for i in $FOUNDPACKAGES; do echo " ... $i" > $OUTPUT; done)
	if [[ "$FOUNDPACKAGES" == "" ]]; then
		echo "No packages found matching file pattern $pkg" >&2
		exit 1
	fi
	for i in $FOUNDPACKAGES; do
		PACKAGENAME=$(echo $i | grep -o -E "^[^:]+")
		PACKAGEARCH=$(echo $i | grep -o -E ":[^:,]+")
		echo "Looking for $PACKAGENAME-dbg/dbgsym$PACKAGEARCH" > $OUTPUT
		SYMBOLPKG=$PACKAGENAME-dbgsym
		SYMBOL=$(apt-cache search $SYMBOLPKG)
		if [[ "$SYMBOL" == "" ]]; then
			# Try -dbg variant
			SYMBOLPKG=$PACKAGENAME-dbg
			SYMBOL=$(apt-cache search $SYMBOLPKG)
		fi
		if [[ "$SYMBOL" != "" ]]; then
			echo " ... Found symbols for $i -> $SYMBOL" > $OUTPUT
			SYMBOLPACKAGES=$(echo $SYMBOLPACKAGES $SYMBOLPKG$PACKAGEARCH)
		else
			MISSINGPACKAGES=$(echo $MISSINGPACKAGES $PACKAGENAME$PACKAGEARCH)
		fi
	done
done
if [[ "$MISSINGPACKAGES" != "" ]]; then
	echo "Couldn't find symbols for the following packages:" >&2
	echo "$MISSINGPACKAGES" | tr " " "\n" | sort -u | tr "\n" " " >&2
fi

# Print the resulting packages and remove duplicates
echo "$SYMBOLPACKAGES" | tr " " "\n" | sort -u | tr "\n" " "



