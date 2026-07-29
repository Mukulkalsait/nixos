#!/usr/bin/env bash

window_exists() {
  local class="$1"

  hyprctl clients -j |
    jq -e --arg class "$class" \
      '.[] | select(.class == $class)' \
      >/dev/null 2>&1
}

window_focus() {
  local class="$1"

  hyprctl dispatch \
    "hl.dsp.focus({ window = \"class:^${class}$\" })"
}

window_close() {
  local class="$1"

  hyprctl dispatch \
    "hl.dsp.window\.close({ window = \"class:^${class}$\" })"
}

window_info() {
  local class="$1"

  hyprctl clients -j |
    jq -e --arg class "$class" \
      '.[] | select(.class == $class)'
}

window_width() {
  window_info "$1" | jq -r '.size[0]'
}

window_height() {
  window_info "$1" | jq -r '.size[1]'
}

window_resize() {
  local class="$1"
  local width="$2"
  local height="$3"

  hyprctl dispatch \
    "hl.dsp.window\.resize({
            window = \"class:^${class}$\",
            x = ${width},
            y = ${height}
        })"
}

window_move() {
  local class="$1"
  local x="$2"
  local y="$3"

  hyprctl dispatch \
    "hl.dsp.window\.move({
            window = \"class:^${class}$\",
            x = ${x},
            y = ${y}
        })"
}

monitor_width() {
  hyprctl monitors -j | jq -r '.[0].width'
}

monitor_height() {
  hyprctl monitors -j | jq -r '.[0].height'
}

monitor_percent_width() {
  local percent="$1"
  local width

  width="$(monitor_width)"
  echo $((width * percent / 100))
}

monitor_percent_height() {
  local percent="$1"
  local height

  height="$(monitor_height)"
  echo $((height * percent / 100))
}

window_resize_percent() {
  local class="$1"
  local width_percent="$2"
  local height_percent="$3"

  local width
  local height

  width="$(monitor_percent_width "$width_percent")"
  height="$(monitor_percent_height "$height_percent")"

  window_resize "$class" "$width" "$height"
}

window_move_percent() {
  local class="$1"
  local x_percent="$2"
  local y_percent="$3"

  local x
  local y

  x="$(monitor_percent_width "$x_percent")"
  y="$(monitor_percent_height "$y_percent")"

  window_move "$class" "$x" "$y"
}

window_debug() {
  local class="$1"

  echo "Window: $class"

  if ! window_exists "$class"; then
    echo "Status: NOT FOUND"
    return 1
  fi

  echo "Status: EXISTS"
  echo "Monitor: $(monitor_width)x$(monitor_height)"
  echo "Window: $(window_width "$class")x$(window_height "$class")"

  window_info "$class"
}
