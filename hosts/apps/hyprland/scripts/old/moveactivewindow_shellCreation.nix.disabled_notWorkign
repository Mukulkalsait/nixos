{ config, pkgs, ... }:
{
  # Create the script in ~/.config/hypr/scripts
  home.file.".config/hypr/scripts/moveactivewindow.sh" = {
    text = ''
      #!/bin/sh
      DIR=$1

      if hyprctl activewindow -j | jq -r .floating | grep -q "true"; then
          case "$DIR" in
              h) hyprctl dispatch moveactive -30 0 ;;
              l) hyprctl dispatch moveactive 30 0 ;;
              k) hyprctl dispatch moveactive 0 -30 ;;
              j) hyprctl dispatch moveactive 0 30 ;;
          esac
      else
          case "$DIR" in
              h) hyprctl dispatch movewindow l ;;
              l) hyprctl dispatch movewindow r ;;
              k) hyprctl dispatch movewindow u ;;
              j) hyprctl dispatch movewindow d ;;
          esac
      fi
    '';
    executable = true;
  };

  wayland.windowManager.hyprland.settings = {
    binde = [

      # IMP: Active Window IN WORKSPACE
      "$mainMod SHIFT CTRL, h, exec, ~/.config/hypr/scripts/moveactivewindow.sh h"
      "$mainMod SHIFT CTRL, l, exec, ~/.config/hypr/scripts/moveactivewindow.sh l"
      "$mainMod SHIFT CTRL, k, exec, ~/.config/hypr/scripts/moveactivewindow.sh k"
      "$mainMod SHIFT CTRL, j, exec, ~/.config/hypr/scripts/moveactivewindow.sh j"
    ];
  };
}

