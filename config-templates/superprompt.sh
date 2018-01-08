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
    LINE_COLOR="\[\033[38;5;238m\]"
    WHITE_NORMAL="\[\033[37m\]"
    WHITE_BOLD="\[\033[1;37m\]"
    RESET="\[\033[0m\]"

    PATHSTRING="\$(pwd | sed \"s:$HOME:~:g\" | sed \"s#\(/[^/]\{1,\}/[^/]\{1,\}/[^/]\{1,\}/\).*\(/[^/]\{1,\}/[^/]\{1,\}\)/\{0,1\}#\1…\2#g\")"

    BASEPART="${debian_chroot:+($debian_chroot)}"
    USERPART="${BLUEISH_NORMAL}\u@${BLUEISH_BOLD}\h"
    SEPARATOR1PART="${RESET}:"
    PATHPART="${GREENISH_BOLD}${PATHSTRING}"
    SEPARATOR2PART=" "
    PROMPTPART="${WHITE_BOLD}›"
    ENDPART=" "

    # https://gist.github.com/mkottman/1936195
    PS_LINE=$(printf -- '—%.0s' {1..200})
    PS_FILL="${LINE_COLOR}\[\033[s\]\${PS_LINE:0:$COLUMNS}\[\033[u\]"

    PS1="\${BASEPART}${PS_FILL}${USERPART}${SEPARATOR1PART}${PATHPART}${SEPARATOR2PART}\n${PROMPTPART}${ENDPART}"
    PS2="${PROMPTPART}${RESET}"

    trap '[[ -t 1 ]] && tput sgr0' DEBUG
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w › '
fi
unset color_prompt

