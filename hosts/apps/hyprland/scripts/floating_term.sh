#!/usr/bin/env bash

CLASS="floating_window"

# If exists → kill it
if hyprctl clients | grep -q "class:$CLASS"; then
  hyprctl dispatch closewindow class:$CLASS ||
    pkill -f "ghostty --class=$CLASS"
else
  ghostty \
    --class="$CLASS" \
    --title="Floating Window ☠️" \
    -o background_opacity=1.0 \
    -o background=#1e1e2e \
    -e zsh -c "tmux attach -t float || tmux new -s float" &

  # Wait until window appears
  until hyprctl clients | grep -q "class: $CLASS"; do
    sleep 0.05
  done

  # Size: 45% width, 40% height
  hyprctl dispatch resizeactive exact 45% 40%

  # Position: bottom-right
  hyprctl dispatch moveactive exact 55% 60%
fi
