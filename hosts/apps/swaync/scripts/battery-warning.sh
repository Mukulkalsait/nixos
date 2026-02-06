#!/usr/bin/env bash

BATTERY_LEVEL=$(cat /sys/class/power_supply/BAT1/capacity)
BATTERY_STATUS=$(cat /sys/class/power_supply/BAT1/status)

if [ "$BATTERY_STATUS" = "Discharging" ]; then
  if [ "$BATTERY_LEVEL" -le 5 ]; then
    notify-send -a "battery" -u critical -t 0 -i battery-caution "Battery Critical!" "Only ${BATTERY_LEVEL}% remaining!\nSystem will shutdown soon!"
  elif [ "$BATTERY_LEVEL" -le 10 ]; then
    notify-send -a "battery" -u critical -i battery-low "Battery Low!" "${BATTERY_LEVEL}% remaining\nPlease plug in charger!"
  elif [ "$BATTERY_LEVEL" -le 20 ]; then
    notify-send -a "battery" -u normal -i battery-low "Battery Low" "${BATTERY_LEVEL}% remaining"
  fi
fi
