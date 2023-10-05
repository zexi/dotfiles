#!/bin/bash

my_logger()
{
    local msg="toggle-lid-dpms.sh: $*"
    echo "$msg"
    logger "$msg"
}

if [[ x"$1" == "xsleep" ]]; then
    my_logger "sleep 10s before toggle lid DPMS"
    sleep 10
fi

if grep -q open /proc/acpi/button/lid/LID/state; then
    my_logger "LID is open, turn on screen"
    cmd="setterm --blank poke --term linux >/dev/tty1 </dev/tty1"
    my_logger "$cmd"
    eval "$cmd"
else
    my_logger "LID is close, turn off screen"
    cmd='setterm --blank force --term linux >/dev/tty1 </dev/tty1'
    my_logger "$cmd"
    eval "$cmd"
fi
