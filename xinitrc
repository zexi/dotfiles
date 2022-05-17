#!/bin/sh

# Make sure this is before the 'exec' command or it won't be sourced.
[ -f /etc/xprofile  ] && source /etc/xprofile
[ -f ~/.xprofile  ] && source ~/.xprofile

session=${1:-i3}

case $session in
    i3|i3wm ) exec i3;;
    xfce|xfce4 ) exec startxfce4;;
    * ) exec $1;;
esac
