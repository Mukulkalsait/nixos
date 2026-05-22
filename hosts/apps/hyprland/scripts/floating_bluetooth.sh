#!/usr/bin/env bash

# If impala exists → kill it
if hyprctl clients | grep -q "class: bluetooth"; then
  hyprctl dispatch closewindow class:bluetuith || pkill -f "kitty --class=bluetuith"
else
  kitty --class="bluetooth" --title="BlueTuiTh 🎧" -e bluetuith &
  sleep 0.1
  hyprctl dispatch resizeactive exact 28% 65%
  hyprctl dispatch moveactive exact 62% 3%
fi
