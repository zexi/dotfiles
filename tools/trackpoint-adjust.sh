#!/bin/sh

SPEED=255
SENSITIVITY=175

echo -n $SPEED > /sys/devices/platform/i8042/serio1/serio2/speed
echo -n $SENSITIVITY > /sys/devices/platform/i8042/serio1/serio2/sensitivity
