#!/bin/bash
EXTERNAL_OUTPUT="DP-2-2"
INTERNAL_OUTPUT="eDP-1"

echo "SWITCHING MOITOR MODE"

# if we don't have a file, start at zero
if [ ! -f "/tmp/monitor_mode.dat" ] ; then
  monitor_mode="ALL"

# otherwise read the value from the file
else
  monitor_mode=`cat /tmp/monitor_mode.dat`
fi

if [ $monitor_mode = "ALL" ]; then
        monitor_mode="EXTERNAL"
        xrandr --output $INTERNAL_OUTPUT --off --output $EXTERNAL_OUTPUT --auto
elif [ $monitor_mode = "EXTERNAL" ]; then
        monitor_mode="INTERNAL"
        xrandr --output $INTERNAL_OUTPUT --auto --output $EXTERNAL_OUTPUT --off
elif [ $monitor_mode = "INTERNAL" ]; then
        monitor_mode="CLONES"
        xrandr --output $INTERNAL_OUTPUT --auto --output $EXTERNAL_OUTPUT --auto --same-as $INTERNAL_OUTPUT
else
        monitor_mode="ALL"
        xrandr --output $INTERNAL_OUTPUT --auto --output $EXTERNAL_OUTPUT --auto --left-of $INTERNAL_OUTPUT
fi
echo "${monitor_mode}" > /tmp/monitor_mode.dat
echo "${monitor_mode}"
echo "monitor_mode"
