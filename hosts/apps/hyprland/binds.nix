{ pkgs, config, ... }:
# let
# Y: EXAPMPE OF WRITING SCRIPTS.
#-----------------------------------
# booksDir = "$HOME/Downloads/books";
# booksScript = pkgs.writeScriptBin "open_books" ''
#   #!/bin/sh
#   BOOKS_DIR="${booksDir}"
#   BOOK=$(find "$BOOKS_DIR" -type f \( -iname "*.pdf" -o -iname "*.epub" -o -iname "*.djvu" \) | wofi --dmenu --prompt "Select a book" --width 1200 --height 400)
#   if [[ -n "$BOOK" ]]; then
#       zathura "$BOOK" &
#   else
#       echo "No book selected."
#   fi
# '';
#in
{

  # Y: Script Import.
  # home.packages = [ booksScript ];

  # imports = [ 
  #   # ./scripts/moveactivewindow_shellCreation.nix # Y: Active Window Movements
  # ];

  wayland.windowManager.hyprland.settings = {
    bind = [

      # IMP: Application:
      "$mainMod, Q, killactive," # Y: Exit Window

      "$mainMod , C, exec , kitty zsh -ic 'fastfetch; exec zsh'"
      "$mainMod , I, exec , ghostty "
      # "$mainMod, C, exec, $TERMINAL" # fallback just in case.
      "$mainMod SHIFT, I,  exec, [float; move 20% 5%; size 60% 60%] $TERMINAL"
      "$mainMod, B,  exec, $BROWSER" # Zen
      "$mainMod, N,  exec,$TERMINAL -e $EDITOR" # Nvim
      "$mainMod, E, exec,$TERMINAL -e $FILEMANAGER" # yazi
      "CTRL SHIFT, Escape,  exec, $TASKMANAGER" # Mission Center.
      # "CTRL SHIFT, Escape,  exec, kitty -e btop" # Y: btop

      # DIV: Screen
      "$mainMod, F,  fullscreen"
      "$mainMod SHIFT, F, togglefloating," # TAG: Borderles Window

      # B: Menu: 
      "$mainMod, SPACE, exec, $menu -show drun" # Menu
      "$mainMod ALT, SPACE, exec, $menu -show run" # All Cmds
      "$mainMod , slash, exec, $menu -show keys" # Keybings
      # "$mainMod,       V, exec, cliphist list | $menu --dmenu | cliphist decode | wl-copy" # R: unused but working

      # DX: LOCKING + EXIT
      "$mainMod SHIFT, 0, exit,"
      "$mainMod, 0, exec, loginctl lock-session" # Y: lockscreen

      # Y: Special Space
      "$mainMod,       S, togglespecialworkspace, magic"
      "$mainMod SHIFT, S, movetoworkspace, special:magic"

      # G: Mislenious: 
      "$mainMod,       9, exec, swaync-client -t" # TAG: NOTIFICATIONS:
      "$mainMod Shift, P, exec, hyprpicker -an" # TAG: Pick color (Hex) >> clipboard#

      # Y: Movements
      # IMP: FOCUS ✅
      "$mainMod, H, movefocus, l"
      "$mainMod, L, movefocus, r"
      "$mainMod, K, movefocus, u"
      "$mainMod, J, movefocus, d"
      # IMP: WINDOWS ✅ 
      "$mainMod SHIFT, H,  swapwindow, l"
      "$mainMod SHIFT, L, swapwindow, r"
      "$mainMod SHIFT, K,    swapwindow, u"
      "$mainMod SHIFT, J,  swapwindow, d"
      "ALT, Tab, cyclenext"
      # IMP: Workspace Move ✅ 
      "$mainMod CTRL, 0, workspace, empty" # Y: navigate to the nearest empty workspace
      "$mainMod CTRL, L, workspace, r+1"
      "$mainMod CTRL, H, workspace, r-1"
      "$mainMod, mouse_up,  workspace, e-1"
      "$mainMod, mouse_down, workspace, e+1"
      # IMP: Move Window in Workspace #UT 
      "$mainMod CTRL SHIFT, L, movetoworkspace, r+1"
      "$mainMod CTRL SHIFT, H, movetoworkspace, r-1"
      # IMP: MOVE Group  #UT
      "$mainMod CTRL SHIFT, bracketright,  changegroupactive, b"
      "$mainMod CTRL SHIFT, bracketleft,  changegroupactive, f"
      # IMP: Moving windows to workspaces ✅
      "$mainMod SHIFT, 1, movetoworkspacesilent, 1"
      "$mainMod SHIFT, 2, movetoworkspacesilent, 2"
      "$mainMod SHIFT, 3, movetoworkspacesilent, 3"
      "$mainMod SHIFT, 4, movetoworkspacesilent, 4"
      "$mainMod SHIFT, 5, movetoworkspacesilent, 5"
      "$mainMod SHIFT, 6, movetoworkspacesilent, 6"
      "$mainMod SHIFT, 7, movetoworkspacesilent, 7"
      "$mainMod SHIFT, 8, movetoworkspacesilent, 8"
      "$mainMod SHIFT, 9, movetoworkspacesilent, 9"
      "$mainMod SHIFT, 0, movetoworkspacesilent, 10"

      # IMP: Resizeing windows         X  Y   ✅ 
      "$mainMod ALT, H, resizeactive, -30 0"
      "$mainMod ALT, L, resizeactive,  30 0"
      "$mainMod ALT, K, resizeactive,  0 -30"
      "$mainMod ALT, J, resizeactive,  0  30"

      # FUN_1: costume script:
      "$mainMod SHIFT, W, exec, ${config.home.homeDirectory}/.config/swww/change.sh"

      # B: ready to replace
      # "$mainMod,       P, pin," # TAG: no idea
      # "$mainMod,       J, togglesplit,"  #TAG:  toggle between screen
      # "$mainMod SHIFT, B, exec, pkill -SIGUSR1 waybar"
      # "$mainMod,       ., exec, bemoji -cn" #not working
      #"$mainMod,       W, exec, ${booksScript}/bin/open_books" Y: script exicution example

      # DX: Some window Movements are in ./scripts/moveactivewindow_shellCreation.nix
      # Switching workspaces -----------Y: turned off
      # "$mainMod, 1, workspace, 1"
      # "$mainMod, 2, workspace, 2"
      # "$mainMod, 3, workspace, 3"
      # "$mainMod, 4, workspace, 4"
      # "$mainMod, 5, workspace, 5"
      # "$mainMod, 6, workspace, 6"
      # "$mainMod, 7, workspace, 7"
      # "$mainMod, 8, workspace, 8"
      # "$mainMod, 9, workspace, 9"
      # "$mainMod, 0, workspace, 10"

      # DX: IMPORTED BUT NOT ACTIVATED AS WE DONT HAHVE THE SCRIPTS
      #  $mainMod Alt, k,  exec, $scrPath/wbarconfgen.sh n # next waybar mode
      #  $mainMod Alt, j,  exec, $scrPath/wbarconfgen.sh p # previous waybar mode
      # ------------------
      #  $mainMod Shift, W,  exec, pkill -x rofi || $scrPath/wallpaper.sh -SG # launch wallpaper select menu
      #  $mainMod Shift, T,  exec, pkill -x rofi || $scrPath/themeselect.sh # launch theme select menu
      #  $mainMod Shift, R,  exec, pkill -x rofi || $scrPath/wallbashtoggle.sh -m # launch wallbash mode select menu
      #  $mainMod+Shift, Y,  exec, pkill -x rofi || $scrPath/animations.sh --select # launch animations select menu
      #  $mainMod+Shift, U,  exec, pkill -x rofi || $scrPath/hyprlock.sh --select # launch hyprlock layout select menu
      # "$mainMod CTRL SHIFT, H, exec, hyprctl dispatch movetoworkspacesilent r-1; hyprctl dispatch workspace r-1"

      # HEAD: if we want 2 actions in 1 key
      # "$mainMod CTRL SHIFT, L, exec, hyprctl dispatch movetoworkspacesilent r+1; hyprctl dispatch workspace r+1"

    ];

    # Move/resize windows with mainMod + LMB/RMB and dragging
    bindm = [
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
      #B: awesomes
      "$mainMod, Z,  movewindow"
      "$mainMod, X,  resizewindow"
    ];

    # Laptop multimedia keys for volume and LCD brightness
    bindel = [
      ",XF86AudioRaiseVolume,  exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
      ",XF86AudioLowerVolume,  exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ",XF86AudioMute,         exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ",XF86AudioMicMute,      exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"

      "$mainMod, bracketright, exec, brightnessctl s 10%+"
      "$mainMod, bracketleft,  exec, brightnessctl s 10%-"

      # just for examples
      # ", F11,  exec, $scrPath/volumecontrol.sh -o d # decrease volume"
      # ", F12,  exec, $scrPath/volumecontrol.sh -o i # increase volume"
      # ", XF86AudioLowerVolume,  exec, $scrPath/volumecontrol.sh -o d # decrease volume"
      # ", XF86AudioRaiseVolume,  exec, $scrPath/volumecontrol.sh -o i # increase volume"
    ];

    # Audio playback
    bindl = [
      ", XF86AudioNext,  exec, playerctl next"
      ", XF86AudioPause, exec, playerctl play-pause"
      ", XF86AudioPlay,  exec, playerctl play-pause"
      ", XF86AudioPrev,  exec, playerctl previous"
      ", Print, exec,hyprshot -m region -o ~/1_file/9_Pictures/Screenshots/ " # Y: Screen shot.
      # ", F10, exec, $scrPath/volumecontrol.sh -o m " # toggle audio mute
      # ", XF86AudioMute, exec, $scrPath/volumecontrol.sh -o m " # toggle audio mute
      # ", XF86AudioMicMute, exec, $scrPath/volumecontrol.sh -i m " # toggle microphone mute
      # binddl = $mainMod Alt, P, $d print monitor , exec, $scrPath/screenshot.sh m # monitor screenshot capture
      # binddl = , Print, $d print all monitors , exec, $scrPath/screenshot.sh p # all monitors screenshot capture
    ];
  };
}

