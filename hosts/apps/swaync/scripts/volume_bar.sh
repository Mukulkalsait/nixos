#!/usr/bin/env bash

vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2*100)}')
muted=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -o MUTED)

if [[ "$muted" == "MUTED" ]]; then
  icon="🔇"
  value=0
else
  value=$vol
  if [ "$value" -lt 30 ]; then
    icon="🔈"
  elif [ "$value" -lt 70 ]; then
    icon="🔉"
  else
    icon="🔊"
  fi
fi

notify-send \
  -h int:value:"$value" \
  -h string:x-canonical-private-synchronous:volume \
  "$icon  Volume ${value}%"
