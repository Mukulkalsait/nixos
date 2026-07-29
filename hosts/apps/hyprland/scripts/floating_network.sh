#!/usr/bin/env bash

CLASS="nmtui"

WIDTH=36
HEIGHT=50
X=4
Y=48

exists() {
  hyprctl clients -j |
    jq -e --arg class "$CLASS" \
      '.[] | select(.class == $class)' \
      >/dev/null 2>&1
}

if exists; then
  hyprctl dispatch 'hl.dsp.window.close({ window = "class:^nmtui$" })'
else
  setsid -f kitty \
    --class="$CLASS" \
    --title="NMTUI 🛜" \
    -e nmtui \
    </dev/null >/dev/null 2>&1

  sleep 0.2

  hyprctl dispatch "hl.dsp.window.resize({
    window = \"class:^${CLASS}$\",
    x = $((1920 * WIDTH / 100)),
    y = $((1200 * HEIGHT / 100))
  })"

  hyprctl dispatch "hl.dsp.window.move({
    window = \"class:^${CLASS}$\",
    x = $((1920 * X / 100)),
    y = $((1200 * Y / 100))
  })"
fi
