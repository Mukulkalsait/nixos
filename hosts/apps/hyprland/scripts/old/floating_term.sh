#!/usr/bin/env bash

CLASS="floating_window"
ACTION="$1"

exists() {
  hyprctl clients -j | jq -e ".[] | select(.class==\"$CLASS\")" >/dev/null 2>&1
}

focus() {
  hyprctl dispatch focuswindow "class:^${CLASS}$"
}

small() {
  hyprctl dispatch resizeactive exact 49% 44%
  hyprctl dispatch moveactive exact 50% 55%
}

large() {
  hyprctl dispatch resizeactive exact 84% 80%
  hyprctl dispatch moveactive exact 8% 16%
}

is_large() {
  # Changed threshold from 1000 to 800 (since your window width is ~932)
  hyprctl clients -j | jq -e \
    ".[] | select(.class==\"$CLASS\" and .size[0] > 800)" >/dev/null 2>&1
}

case "$ACTION" in
toggle)
  if exists; then
    hyprctl dispatch closewindow "class:^${CLASS}$" || pkill -f "kitty --class=$CLASS"
  else
    kitty \
      --class="$CLASS" \
      --title="Floating Window ☠️" \
      -e bash -c "tmux attach -t Float || tmux new -s Float" &

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
