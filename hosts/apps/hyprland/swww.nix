# Y: this file generates 2 scripts  A and B 
{ config, pkgs, ... }:

let
  wallpaperDir = "${config.home.homeDirectory}/A_Files/9_Pictures/Walpapers";
  queueFile = "\${XDG_CACHE_HOME:-$HOME/.cache}/swww_wallpaper_queue";
in
{
  # Y: A => Script 1: Startup
  xdg.configFile."swww/start.sh".text = ''
    #!/bin/sh
    wallpaperDir="${wallpaperDir}"
    queueFile="${queueFile}"

    swww init &
    sleep 1

    # Rebuild queue at startup
    find "$wallpaperDir" -type f | shuf > "$queueFile"

    # First wallpaper from queue
    firstWp=$(head -n 1 "$queueFile")
    tail -n +2 "$queueFile" > "$queueFile.tmp" && mv "$queueFile.tmp" "$queueFile"

    swww img "$firstWp" \
      --transition-step 90 \
      --transition-fps 60 \
      --transition-type any \
      --transition-duration 4 \
      --resize crop
  '';
  xdg.configFile."swww/start.sh".executable = true;

  # Y: B =>  Script 2: Change wallpaper
  xdg.configFile."swww/change.sh".text = ''
    #!/bin/sh
    wallpaperDir="${wallpaperDir}"
    queueFile="${queueFile}"

    # If queue is empty, regenerate
    if [ ! -s "$queueFile" ]; then
      find "$wallpaperDir" -type f | shuf > "$queueFile"
    fi

    # Next wallpaper
    nextWp=$(head -n 1 "$queueFile")
    tail -n +2 "$queueFile" > "$queueFile.tmp" && mv "$queueFile.tmp" "$queueFile"

    swww img "$nextWp" \
      --transition-step 90 \
      --transition-fps 60 \
      --transition-type any \
      --transition-duration 2 \
      --resize crop \
      --transition-bezier 0.55,0.055,0.675,0.09
  '';
  xdg.configFile."swww/change.sh".executable = true;

  # Hook into Hyprland startup
  wayland.windowManager.hyprland.extraConfig = ''
    exec-once = ${config.home.homeDirectory}/.config/swww/start.sh
  '';
}

