#!/bin/bash

pkill -f nm-applet
pkill -f blueman-applet

bluman-applet &
nm-applet --indicator &
