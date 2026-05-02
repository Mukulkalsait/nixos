#!/usr/bin/env bash

CLASS="floating_window"
ACTION="$1"

exists() {
  hyprctl clients | grep -q "class: $CLASS"
}

focus() {
  hyprctl dispatch focuswindow class:$CLASS
}

small() {
  hyprctl dispatch resizeactive exact 50% 45%
  hyprctl dispatch moveactive exact 50% 55%
}

large() {
  hyprctl dispatch resizeactive exact 84% 80%
  hyprctl dispatch moveactive exact 8% 16%
}

is_large() {
  hyprctl clients -j | jq -e \
    ".[] | select(.class==\"$CLASS\" and .size[0] > 1000)" >/dev/null
}

case "$ACTION" in
toggle)
  if exists; then
    hyprctl dispatch closewindow class:$CLASS ||
      pkill -f "kitty --class=$CLASS"
  else
    kitty \
      --class="$CLASS" \
      --title="Floating Window ☠️" \
      -e bash -c "tmux attach -t float || tmux new -s float" &

    until exists; do sleep 0.05; done
    focus
    if is_large; then
      large
    else
      small
    fi
  fi
  ;;

resize)
  if exists; then
    focus
    if is_large; then
      small
    else
      large
    fi
  fi
  ;;

*)
  echo "Usage: $0 {toggle|resize}"
  ;;
esac
