#!/bin/sh

SPEED=200
SENSITIVITY=200

echo -n $SPEED > /sys/devices/platform/i8042/serio1/serio2/speed
echo -n $SENSITIVITY > /sys/devices/platform/i8042/serio1/serio2/sensitivity
