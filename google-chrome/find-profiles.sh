#!/bin/bash
PREFPATH=$(realpath ~/.config/google-chrome)
PREFS=$(find $PREFPATH -name Preferences | grep -v "System Profile" | xargs "--delimiter=\n" grep -E -o '"email":"([^\"]+)"' | sed -r 's/"email":"([^"]+)"/\1/g' | sed "s:$PREFPATH/\(.*\)/Preferences:\1:g")
while IFS=''; read -ra PREF; do
    PROFILE=$(echo $PREF | cut -d: -f1)
    EMAIL=$(echo $PREF | cut -d: -f2)
    echo "Profile '$PROFILE' associated with '$EMAIL'"
done <<< $PREFS

#for i in $PREFS; do
#    echo \"$i\"
#done
#for p in $(find ~/.config/google-chrome -name Preferences | grep -v "System Profile" | perl -p -e "s/\n/\0/;" | xargs -0) ; do
#    echo $p
#done
