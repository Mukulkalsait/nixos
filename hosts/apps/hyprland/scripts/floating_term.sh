#!/usr/bin/env bash

set -u

CLASS="floating_window"
ACTION="${1:-}"

# ----------------------------------------------------------
# Layout configuration (percentages)
# ----------------------------------------------------------

SMALL_W=49
SMALL_H=44
SMALL_X=50
SMALL_Y=55

LARGE_W=84
LARGE_H=80
LARGE_X=8
LARGE_Y=16

# ----------------------------------------------------------
# Monitor size
# ----------------------------------------------------------

MON_W=$(hyprctl monitors -j | jq '.[0].width')
MON_H=$(hyprctl monitors -j | jq '.[0].height')

# ----------------------------------------------------------
# Convert percentage -> pixels
# ----------------------------------------------------------

pct_w() {
  echo $((MON_W * $1 / 100))
}

pct_h() {
  echo $((MON_H * $1 / 100))
}

# ----------------------------------------------------------
# Logging
# ----------------------------------------------------------

log() {
  echo "[DEBUG] $*"
}

# ----------------------------------------------------------
# Window helpers
# ----------------------------------------------------------

exists() {
  hyprctl clients -j | jq -e ".[] | select(.class == \"$CLASS\")" >/dev/null 2>&1
}

focus() {
  log "Focusing window..."

  hyprctl dispatch "hl.dsp.focus({
        window = \"class:^${CLASS}$\"
    })"
}

close_window() {
  hyprctl dispatch "hl.dsp.window.close({
        window = \"class:^${CLASS}$\"
    })"
}

resize_window() {

  local W
  local H

  W=$(pct_w "$1")
  H=$(pct_h "$2")

  log "Resize -> ${W}x${H}"

  hyprctl dispatch "hl.dsp.window.resize({
        window = \"class:^${CLASS}$\",
        x = ${W},
        y = ${H}
    })"
}

move_window() {

  local X
  local Y

  X=$(pct_w "$1")
  Y=$(pct_h "$2")

  log "Move -> ${X},${Y}"

  hyprctl dispatch "hl.dsp.window.move({
        window = \"class:^${CLASS}$\",
        x = ${X},
        y = ${Y}
    })"
}

small() {

  log "Applying SMALL layout..."

  resize_window "$SMALL_W" "$SMALL_H"
  move_window "$SMALL_X" "$SMALL_Y"
}

large() {

  log "Applying LARGE layout..."

  resize_window "$LARGE_W" "$LARGE_H"
  move_window "$LARGE_X" "$LARGE_Y"
}

is_large() {

  hyprctl clients -j |
    jq -e ".[] | select(.class == \"$CLASS\" and .size[0] > 1000)" \
      >/dev/null 2>&1
}

# ----------------------------------------------------------
# Main
# ----------------------------------------------------------

case "$ACTION" in

toggle)

  if exists; then
    log "Window exists. Closing..."
    close_window
    exit 0
  fi

  log "Launching kitty..."

  kitty \
    --class="$CLASS" \
    --title="Floating Window ☠️" \
    -e bash -c "tmux attach -t Float || tmux new -s Float" &

  log "Waiting for window..."

  for i in {1..100}; do

    if exists; then
      log "Window detected after $i attempts."
      break
    fi

    sleep 0.05

  done

  if ! exists; then
    log "Window never appeared."
    exit 1
  fi

  focus

  if is_large; then
    large
  else
    small
  fi
  ;;

resize)

  if ! exists; then
    log "No floating window found."
    exit 0
  fi

  focus

  if is_large; then
    log "Switching LARGE -> SMALL"
    small
  else
    log "Switching SMALL -> LARGE"
    large
  fi
  ;;

*)

  echo "Usage: $0 {toggle|resize}"
  exit 1

  ;;

esac
