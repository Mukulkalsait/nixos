#!/usr/bin/env bash

# If impala exists → kill it
if hyprctl clients | grep -q "class: nmtui"; then
  hyprctl dispatch closewindow class:nmtui || pkill -f "kitty --class=nmtui"
else
  kitty --class="nmtui" --title="NMTUI 󱛆 " -e nmtui &
  sleep 0.1
  hyprctl dispatch resizeactive exact 33% 35%
  hyprctl dispatch moveactive exact 61% 60%
fi
