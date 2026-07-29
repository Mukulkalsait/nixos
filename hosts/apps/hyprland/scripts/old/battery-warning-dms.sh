#!/usr/bin/env bash

STATE_FILE="/tmp/battery_notified_level"

while true; do
  # Skip processing if battery paths don't exist yet during boot
  if [ ! -d "/sys/class/power_supply/BAT1" ]; then
    sleep 60
    continue
  fi

  BATTERY_LEVEL=$(cat /sys/class/power_supply/BAT1/capacity)
  BATTERY_STATUS=$(cat /sys/class/power_supply/BAT1/status)

  # Reset state if plugged in
  if [ "$BATTERY_STATUS" != "Discharging" ]; then
    rm -f "$STATE_FILE"
    sleep 60
    continue
  fi

  LAST_NOTIFIED=$(cat "$STATE_FILE" 2>/dev/null || echo 100)

  if [ "$BATTERY_LEVEL" -le 5 ] && [ "$LAST_NOTIFIED" -gt 5 ]; then
    notify-send -a "battery" -u critical -i battery-caution "Battery Critical! 🪫" "Only ${BATTERY_LEVEL}% remaining!\nSystem will shutdown soon!"
    echo 5 >"$STATE_FILE"
  elif [ "$BATTERY_LEVEL" -le 10 ] && [ "$LAST_NOTIFIED" -gt 10 ]; then
    notify-send -a "battery" -t 2200 -u critical -i battery-low "Battery Super Low! 🪫" "${BATTERY_LEVEL}% remaining\nPlease plug in charger!"
    echo 10 >"$STATE_FILE"
  elif [ "$BATTERY_LEVEL" -le 20 ] && [ "$LAST_NOTIFIED" -gt 20 ]; then
    notify-send -a "battery" -t 2200 -u normal -i battery-low "Battery Low ⚠️" "${BATTERY_LEVEL}% remaining"
    echo 20 >"$STATE_FILE"
  fi

  sleep 60
done
