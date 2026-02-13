#!/usr/bin/env bash

# If impala exists → kill it
if hyprctl clients | grep -q "class: wiremix"; then
  hyprctl dispatch closewindow class:wiremix || pkill -f "kitty --class=wiremix"
else
  kitty --class="wiremix" --title="WireMix-Audio 📢 " -o background_opacity=1.0 -o background=#1e1e2e -e wiremix -v output &
  sleep 0.1
  hyprctl dispatch resizeactive exact 58% 45%
  hyprctl dispatch moveactive exact 2% 3%
fi
