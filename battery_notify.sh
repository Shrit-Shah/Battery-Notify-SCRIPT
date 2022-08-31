#! /bin/bash
set -eu

MIN_BAT=30
MAX_BAT=90

while true ; do

STATUS=$(cat /sys/bus/acpi/drivers/battery/*/power_supply/BAT?/status)
BAT_PERCENTAGE=$(acpi|grep -Po "[0-9]+(?=%)")


if [ $BAT_PERCENTAGE -le $MIN_BAT ]; then # Battery under low limit
 if [ "$STATUS" == "Discharging" ]; then #unplugged
 notify-send "Battery under $MIN_BAT. Please plug in the adapter"
 fi

elif [ $BAT_PERCENTAGE -ge $MAX_BAT ]; then # Battery over high limit
 if [ "$STATUS" == "Charging" ]; then # plugged
 notify-send "Battery above $MAX_BAT. Please remove the adapter"
 fi
fi

 sleep 30 #Repeat every 30 seconds

done
