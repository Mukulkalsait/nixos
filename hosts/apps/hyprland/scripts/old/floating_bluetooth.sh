bash
#!/usr/bin/env bash

CLASS="bluetooth"

exists() {
  hyprctl clients -j |
    jq -e --arg class "$CLASS" \
      '.[] | select(.class == $class)' \
      >/dev/null 2>&1
}

if exists; then
  hyprctl dispatch 'hl.dsp.window.close({ window = "class:^bluetooth$" })'
else
  kitty \
    --class="$CLASS" \
    --title="BlueTuiTh 🎧" \
    -e bluetuith &
fi
