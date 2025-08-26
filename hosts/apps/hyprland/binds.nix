{ pkgs, ... }:
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

  imports = [ 
    ./scripts/moveactivewindow_shellCreation.nix # Y: Active Window Movements
  ];

  wayland.windowManager.hyprland.settings = {
    bind = [

      # Y: Application:
      "$mainMod, E, exec, $fileManager"
      "$mainMod, T, exec, $terminal"
      "$mainMod Alt, T,  exec, [float; move 20% 5%; size 60% 60%] $terminal"
      "$mainMod, C,  exec, $EDITOR"
      "$mainMod, B,  exec, zen"
      "CTRL Shift, Escape,  exec, btop"

      # Y: EXIT
      "$mainMod, Q, killactive,"
      "$mainMod, 0, exec, loginctl lock-session" # Y: lockscreen
      "$mainMod SHIFT, Q, exit,"

      # B: ready to replace
      # "$mainMod,       F, togglefloating," # TAG: flooting window vc connect window
      # "$mainMod,       P, pin," # TAG: no idea
      # "$mainMod,       J, togglesplit,"  # Y:  toggle between screen
      # "$mainMod SHIFT, B, exec, pkill -SIGUSR1 waybar"

      # DX: DELETE IN FUTURE: 
      "$mainMod,       D, exec, $menu --show drun"

      # G: Test or NEW to me: 
      "$mainMod,       ., exec, bemoji -cn" # Y: emoji? 
      "$mainMod,       V, exec, cliphist list | $menu --dmenu | cliphist decode | wl-copy"
      "$mainMod Shift, P, exec, hyprpicker -an" # Pick color (Hex) >> clipboard#


      "$mainMod,       N, exec, swaync-client -t"

      # Y: SCRIPT EXICUTION.
      #"$mainMod,       W, exec, ${booksScript}/bin/open_books"

      # Y: Movements
      # IMP: FOCUS
      "$mainMod, L, movefocus, l" 
      "$mainMod, H, movefocus, r"
      "$mainMod, K, movefocus, u"
      "$mainMod, J, movefocus, d"
      # IMP: WINDOWS
      "$mainMod SHIFT, H,  swapwindow, l" 
      "$mainMod SHIFT, L, swapwindow, r"
      "$mainMod SHIFT, K,    swapwindow, u"
      "$mainMod SHIFT, J,  swapwindow, d"
      "ALT, Tab, cyclenext"
      # IMP: Workspace Move
      "$mainMod CTRL, L, workspace, r+1"  
      "$mainMod CTRL, H, workspace, r-1"
      "$mainMod, mouse_up,  workspace, e-1"
      "$mainMod, mouse_down, workspace, e+1"
      "$mainMod CTRL, 0, workspace, empty" # Y: navigate to the nearest empty workspace
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
      # IMP: MOVE Group
      "$mainMod CTRL, H,  changegroupactive, b"  
      "$mainMod CTRL, L,  changegroupactive, f"
      # IMP: Moving windows to workspaces
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

      # Resizeing windows                     X  Y
      "$mainMod CTRL, L,  resizeactive, -30 0"
      "$mainMod CTRL, H, resizeactive,  30 0"
      "$mainMod CTRL, K,    resizeactive,  0 -30"
      "$mainMod CTRL, J,  resizeactive,  0  30"

      # Scratchpad
      # "$mainMod,       S, togglespecialworkspace,  magic"
      # "$mainMod SHIFT, S, movetoworkspace, special:magic"
      # DX: 
      #  $mainMod Alt, k,  exec, $scrPath/wbarconfgen.sh n # next waybar mode
      #  $mainMod Alt, j,  exec, $scrPath/wbarconfgen.sh p # previous waybar mode
      # ------------------
      #  $mainMod Shift, W,  exec, pkill -x rofi || $scrPath/wallpaper.sh -SG # launch wallpaper select menu
      #  $mainMod Shift, T,  exec, pkill -x rofi || $scrPath/themeselect.sh # launch theme select menu
      #  $mainMod Shift, R,  exec, pkill -x rofi || $scrPath/wallbashtoggle.sh -m # launch wallbash mode select menu
      #  $mainMod+Shift, Y,  exec, pkill -x rofi || $scrPath/animations.sh --select # launch animations select menu
      #  $mainMod+Shift, U,  exec, pkill -x rofi || $scrPath/hyprlock.sh --select # launch hyprlock layout select menu
    ];



    # Move/resize windows with mainMod + LMB/RMB and dragging
    bindm = [
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
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
      # ", Print, exec, grimblast --notify --freeze copysave area"     # Y:grimblast
      # ", F10, exec, $scrPath/volumecontrol.sh -o m " # toggle audio mute
      # ", XF86AudioMute, exec, $scrPath/volumecontrol.sh -o m " # toggle audio mute
      # ", XF86AudioMicMute, exec, $scrPath/volumecontrol.sh -i m " # toggle microphone mute
# binddl = $mainMod Alt, P, $d print monitor , exec, $scrPath/screenshot.sh m # monitor screenshot capture
# binddl = , Print, $d print all monitors , exec, $scrPath/screenshot.sh p # all monitors screenshot capture
    ];
  };
}
