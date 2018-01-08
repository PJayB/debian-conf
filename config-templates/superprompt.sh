#!/bin/bash

# set a fancy prompt
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac
if [ "$color_prompt" = yes ]; then
    # https://upload.wikimedia.org/wikipedia/commons/1/15/Xterm_256color_chart.svg
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[38;5;39m\]\u@\[\033[01;38;5;39m\]\h\[\033[00m\]:\[\033[01;38;5;121m\]\w \[\033[1;37m\]›  \[\033[0m\]'
    BLUEISH_NORMAL="\[\033[0;38;5;39m\]"
    BLUEISH_BOLD="\[\033[01;38;5;39m\]"
    GREENISH_NORMAL="\[\033[0;38;5;121m\]"
    GREENISH_BOLD="\[\033[01;38;5;121m\]"
    ORANGE_NORMAL="\[\033[00;38;5;202m\]"
    ORANGE_BOLD="\[\033[01;38;5;202m\]"
    RED_NORMAL="\[\033[00;38;5;196m\]"
    RED_BOLD="\[\033[01;38;5;196m\]"
    YELLOW_NORMAL="\[\033[0;38;5;226m\]"
    YELLOW_BOLD="\[\033[01;38;5;226m\]"
    LINE_COLOR="\[\033[0;38;5;238m\]"
    WHITE_NORMAL="\[\033[0;37m\]"
    WHITE_BOLD="\[\033[1;37m\]"
    RESET="\[\033[0m\]"
    SAVECUR="\[\033[s\]"
    RESTORECUR="\[\033[u\]"

    PATHSTRING="\$(pwd | sed \"s:$HOME:~:g\" | sed \"s#\(/[^/]\{1,\}/[^/]\{1,\}/[^/]\{1,\}/\).*\(/[^/]\{1,\}/[^/]\{1,\}\)/\{0,1\}#\1…\2#g\")"

    GITPART="\$(git branch 2> /dev/null | sed 's/^\* \(.*\)$/ ${LINE_COLOR}(${ORANGE_BOLD}git ${RED_NORMAL}\1${LINE_COLOR})/g')"
    HGPART="\$(hg branch 2> /dev/null | sed 's/^\(.*\)$/ ${LINE_COLOR}(${YELLOW_BOLD}hg ${RED_NORMAL}\1${LINE_COLOR})/g')"

    BASEPART="${debian_chroot:+($debian_chroot)}"
    USERPART="${BLUEISH_NORMAL}\u@${BLUEISH_BOLD}\h"
    SEPARATOR1PART="${RESET}:"
    PATHPART="${GREENISH_BOLD}${PATHSTRING}"
    SEPARATOR2PART=""
    SOURCECONTROLPART="${GITPART}${HGPART}"
    PROMPTPART="${WHITE_BOLD}›"
    EXTRAPROMPTPART="${WHITE_BOLD}»"
    ENDPART=" "

    # https://gist.github.com/mkottman/1936195
    PS_LINE=$(printf -- '—%.0s' {1..200})
    PS_FILL="${LINE_COLOR}${SAVECUR}${PS_LINE:0:$COLUMNS}${RESTORECUR}"

    PS1="\${BASEPART}${PS_FILL}${USERPART}${SEPARATOR1PART}${PATHPART}${SEPARATOR2PART}${SOURCECONTROLPART}\n${PROMPTPART}${ENDPART}"
    PS2="${EXTRAPROMPTPART}${ENDPART}"

    trap '[[ -t 1 ]] && tput sgr0' DEBUG
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w › '
fi
unset color_prompt

