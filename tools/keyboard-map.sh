#!/bin/bash

get_keyboard_id() {
    local pattern="$1"
    local id=$(xinput list | grep "$pattern" | sed 's|.*id=\([0-9]\+\).*|\1|')
    echo $id
}
BUILDIN_KEYBOARD_ID=$(get_keyboard_id 'AT Translated Set 2 keyboard')
#HHKB_KEYBOARD_ID=$(xinput list | grep 'Topre Corporation HHKB Professional' | sed 's|.*id=\([0-9]\+\).*|\1|')
HHKB_KEYBOARD_ID=$(get_keyboard_id 'Topre Corporation HHKB Professional')
HHKB_COUNT=$(xinput list | grep -i hhkb | wc -l)

/usr/bin/xset r rate 200 30

echo "BUILDIN_KEYBOARD_ID: $BUILDIN_KEYBOARD_ID" > /tmp/t.log
/usr/bin/setxkbmap -option ctrl:nocaps -device $BUILDIN_KEYBOARD_ID
/usr/bin/setxkbmap -option altwin:swap_lalt_lwin -device $BUILDIN_KEYBOARD_ID

if [ $HHKB_COUNT -eq 1 ]; then
    echo "clean hhkb option $HHKB_KEYBOARD_ID" >> /tmp/t.log
    /usr/bin/setxkbmap -option -device $HHKB_KEYBOARD_ID
fi
