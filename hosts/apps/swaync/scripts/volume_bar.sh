#!/usr/bin/env bash

vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2*100)}')
muted=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -o MUTED)

if [[ "$muted" == "MUTED" ]]; then
  icon="audio-volume-muted"
  text="Muted"
  value=0
else
  if [ "$vol" -lt 30 ]; then
    icon="audio-volume-low"
  elif [ "$vol" -lt 70 ]; then
    icon="audio-volume-medium"
  else
    icon="audio-volume-high"
  fi
  text="Volume"
  value=$vol
fi

notify-send \
  -h int:value:$value \
  -h string:x-canonical-private-synchronous:volume \
  -h string:x-canonical-private-icon:$icon \
  "$text" "$value%"
