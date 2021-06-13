#!/bin/bash

ACTION=$1

KBD_DEV=$(brightnessctl -l -m | grep kbd_backlight | head -n 1 | cut -d ',' -f1)

if [ -z "$KBD_DEV" ]; then
    exit 1
fi

case "$ACTION" in
    "up")
        brightnessctl --device="$KBD_DEV" set +1
        ;;
    "down")
        brightnessctl --device="$KBD_DEV" set 1-
        ;;
    *)
        echo "Usage: $0 [up|down]"
        exit 1
        ;;
esac

