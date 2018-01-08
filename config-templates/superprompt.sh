#!/bin/bash

# set a fancy prompt
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac
if [ "$color_prompt" = yes ]; then
    # https://upload.wikimedia.org/wikipedia/commons/1/15/Xterm_256color_chart.svg
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[38;5;39m\]\u@\[\033[01;38;5;39m\]\h\[\033[00m\]:\[\033[01;38;5;121m\]\w \[\033[1;37m\]›  \[\033[0m\]'
    BLUEISH_NORMAL="\[\033[38;5;39m\]"
    BLUEISH_BOLD="\[\033[01;38;5;39m\]"
    GREENISH_NORMAL="\[\033[38;5;121m\]"
    GREENISH_BOLD="\[\033[01;38;5;121m\]"
    WHITE_NORMAL="\[\033[37m\]"
    WHITE_BOLD="\[\033[1;37m\]"
    RESET="\[\033[0m\]"

    #PATHSTRING=$(pwd | sed "s:$HOME:~:g" | sed "s#\(/[^/]\{1,\}/[^/]\{1,\}/[^/]\{1,\}/\).*\(/[^/]\{1,\}/[^/]\{1,\}\)/\{0,1\}#\1...\2#g")

    BASEPART="${debian_chroot:+($debian_chroot)}"
    USERPART="${BLUEISH_NORMAL}\u@${BLUEISH_BOLD}\h"
    SEPARATOR1PART="${RESET}:"
    PATHPART="${GREENISH_BOLD}\w"
    SEPARATOR2PART=" "
    PROMPTPART="${WHITE_BOLD}›"
    ENDPART="${RESET} "

    PS1="${BASEPART}${USERPART}${SEPARATOR1PART}${PATHPART}${SEPARATOR2PART}${PROMPTPART}${ENDPART}"
    PS2="${GREENISH_BOLD} >"
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w › '
fi
unset color_prompt

