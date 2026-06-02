{ config, pkgs, ... }:

let
  wallpaperDir = "${config.home.homeDirectory}/1_file/9_Pictures/Walpapers";
  queueFile = "\${XDG_CACHE_HOME:-$HOME/.cache}/awww_wallpaper_queue";
in
{
  # Y: A => Script 1: Startup
  xdg.configFile."swww/start.sh".text = ''
    #!/bin/sh

    wallpaperDir="${wallpaperDir}"
    queueFile="${queueFile}"

    mkdir -p "$(dirname "$queueFile")"

    # Start daemon if not running
    pgrep -x awww-daemon >/dev/null || awww-daemon >/dev/null 2>&1 &

    sleep 1

    # Build queue (only valid images, skip /old/)
    find "$wallpaperDir" -type f \
      ! -path "*/old/*" \
      \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) \
      | shuf > "$queueFile"

    # Get first wallpaper
    firstWp=$(head -n 1 "$queueFile")

    # Remove it from queue
    tail -n +2 "$queueFile" > "$queueFile.tmp" && mv "$queueFile.tmp" "$queueFile"

    # Validate file
    [ -f "$firstWp" ] || exit 1

    # Apply wallpaper
    awww img "$firstWp" \
      --transition-step 90 \
      --transition-fps 60 \
      --transition-type any \
      --transition-duration 4 \
      --resize crop \
      >/dev/null 2>&1 &
  '';
  xdg.configFile."swww/start.sh".executable = true;

  # Y: B => Script 2: Change wallpaper
  xdg.configFile."swww/change.sh".text = ''
    #!/bin/sh

    wallpaperDir="${wallpaperDir}"
    queueFile="${queueFile}"

    mkdir -p "$(dirname "$queueFile")"

    # Rebuild queue if empty
    if [ ! -s "$queueFile" ]; then
      find "$wallpaperDir" -type f \
        ! -path "*/old/*" \
        \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) \
        | shuf > "$queueFile"
    fi

    # Get next wallpaper
    nextWp=$(head -n 1 "$queueFile")

    # Remove it from queue
    tail -n +2 "$queueFile" > "$queueFile.tmp" && mv "$queueFile.tmp" "$queueFile"

    # Validate file, rebuild if broken
    if [ ! -f "$nextWp" ]; then
      find "$wallpaperDir" -type f \
        ! -path "*/old/*" \
        \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) \
        | shuf > "$queueFile"
      exit 1
    fi

    # Apply wallpaper
    awww img "$nextWp" \
      --transition-step 90 \
      --transition-fps 60 \
      --transition-type any \
      --transition-duration 2 \
      --resize crop \
      --transition-bezier 0.55,0.055,0.675,0.09 \
      >/dev/null 2>&1 &
  '';
  xdg.configFile."swww/change.sh".executable = true;

  # Hook into Hyprland startup
  wayland.windowManager.hyprland.extraConfig = ''
    exec-once = ${config.home.homeDirectory}/.config/swww/start.sh
  '';
}
