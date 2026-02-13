#!/usr/bin/env bash

# If impala exists → kill it
if hyprctl clients | grep -q "class: wifitui"; then
  hyprctl dispatch closewindow class:wifitui || pkill -f "kitty --class=wifitui"
else
  kitty --class="wifitui" --title="WifiTUI 󱛆 " -e wifitui &
  sleep 0.1
  hyprctl dispatch resizeactive exact 28% 65%
  hyprctl dispatch moveactive exact 62% 3%
fi
