#!/usr/bin/env bash

# If impala exists → kill it
if hyprctl clients | grep -q "class: iwd-impala"; then
  pkill -f "kitty --class iwd-impala"
else
  kitty --class iwd-impala -e impala &
  sleep 0.07
  hyprctl dispatch resizeactive exact 28% 65%
  hyprctl dispatch moveactive exact 72% 3%
fi
