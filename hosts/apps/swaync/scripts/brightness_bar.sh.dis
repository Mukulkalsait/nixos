#!/usr/bin/env bash

brightness=$(brightnessctl get)
max=$(brightnessctl max)
percent=$((brightness * 100 / max))

notify-send \
  -a "brightness" \
  -t 2200 \
  -h int:value:"$percent" \
  -h string:x-canonical-private-synchronous:brightness \
  "🔆 Brightness ${percent}%"
