{ config, pkgs, ... }:

let wallpaperDir = "${config.home.homeDirectory}/1_file/9_Walpapers";
in {
  # Script 1: Startup
  xdg.configFile."swww/start.sh".text = ''
    #!/bin/sh
    # start daemon
    swww init &
    # wait for socket
    sleep 1
    # set random wallpaper
    swww img $(find ${wallpaperDir} -type f | shuf -n 1) \
      --transition-step 90 \
      --transition-fps 60 \
      --transition-type any \
      --resize crop
  '';
  xdg.configFile."swww/start.sh".executable = true;

  # Script 2: Change wallpaper
  xdg.configFile."swww/change.sh".text = ''
    #!/bin/sh
    swww img $(find ${wallpaperDir} -type f | shuf -n 1) \
      --transition-step 90 \
      --transition-fps 60 \
      --transition-type any \
      --transition-duration 2 \
      --resize crop \
      --transition-bezier 0.55,0.055,0.675,0.19
  '';
  xdg.configFile."swww/change.sh".executable = true;

  wayland.windowManager.hyprland.extraConfig = ''
    # Run daemon + initial wallpaper once
    exec-once = ${config.home.homeDirectory}/.config/swww/start.sh
  '';
}

# in bindd= ["$mainMod, ALT, W, exec, ${config.home.homeDirectory}/.config/swww/change.sh"] 
