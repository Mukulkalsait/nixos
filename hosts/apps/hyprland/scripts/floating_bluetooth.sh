#!/usr/bin/env bash

# If impala exists → kill it
if hyprctl clients | grep -q "class: bluetooth"; then
  hyprctl dispatch closewindow class:bluetooth || pkill -f "kitty --class=bluetooth"
else
  kitty --class="bluetooth" --title="BlueTuiTh 🎧" -e bluetuith &
  sleep 0.1
  hyprctl dispatch resizeactive exact 58% 40%
  hyprctl dispatch moveactive exact 2% 55%
fi
