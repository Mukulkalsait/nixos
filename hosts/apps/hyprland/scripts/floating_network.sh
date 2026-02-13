#!/usr/bin/env bash

# If impala exists → kill it
if hyprctl clients | grep -q "class: nmtui"; then
  pkill -f "kitty --class nmtui"
else
  kitty --class="nmtui" --title="NMTUI 󱛆 " -e nmtui &
  sleep 0.07
  hyprctl dispatch resizeactive exact 28% 65%
  hyprctl dispatch moveactive exact 62% 3%
fi
