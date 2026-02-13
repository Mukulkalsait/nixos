#!/usr/bin/env bash

# If impala exists → kill it
if hyprctl clients | grep -q "class: wiremix"; then
  pkill -f "kitty --class wiremix"
else
  kitty --class="wiremix" title="WireMix-Audio 📢 " -e wiremix &
  sleep 0.07
  hyprctl dispatch resizeactive exact 28% 65%
  hyprctl dispatch moveactive exact 15% 3%
fi
