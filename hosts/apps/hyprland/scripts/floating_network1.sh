#!/usr/bin/env bash

# If impala exists → kill it
if hyprctl clients | grep -q "class: wifitui"; then
  hyprctl dispatch closewindow class:wifitui || pkill -f "kitty --class=wifitui"
else
  kitty --class="wifitui" --title="WifiTUI 󱛆 " -e wifitui &
  sleep 0.1
  hyprctl dispatch moveactive exact 61% 3%
  hyprctl dispatch resizeactive exact 28% 55%
fi
