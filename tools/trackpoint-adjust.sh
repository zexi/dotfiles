#!/bin/sh

SPEED=255
SENSITIVITY=175

echo -n $SPEED > /sys/devices/platform/i8042/serio1/serio2/speed
echo -n $SENSITIVITY > /sys/devices/platform/i8042/serio1/serio2/sensitivity

/usr/bin/xinput set-prop "ELAN1201:00 04F3:3098 Touchpad" "libinput Tapping Enabled" 1
/usr/bin/xinput set-prop "ELAN1201:00 04F3:3098 Touchpad" "libinput Natural Scrolling Enabled" 1
/usr/bin/xinput set-prop "ELAN1201:00 04F3:3098 Touchpad" "libinput Accel Speed" 0.5
