source ~/.config/hypr/sc/lib/window.sh

CLASS=wiremix

toggle_window "$CLASS" \
  "WireMix-Audio 📢" \
  "wiremix -v output"

window_resize_percent "$CLASS" 58 50
window_move_percent "$CLASS" 5 3
