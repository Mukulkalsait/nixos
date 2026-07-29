#!/usr/bin/env bash

CLASS="wifitui"

WIDTH=24
HEIGHT=64
X=75
Y=6

exists() {
  hyprctl clients -j |
    jq -e --arg class "$CLASS" \
      '.[] | select(.class == $class)' \
      >/dev/null 2>&1
}

if exists; then
  hyprctl dispatch 'hl.dsp.window.close({ window = "class:^wifitui$" })'
else
  setsid -f kitty \
    --class="$CLASS" \
    --title="WifiTUI 📶" \
    -e wifitui \
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
