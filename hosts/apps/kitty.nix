# Y: kitty.nix

{ lib, config, pkgs, ... }: {

  # Kitty
  programs.kitty = {
    enable = true;
    themeFile = "Catppuccin-Mocha";
    font = {
      size = 9;
      # ======= FONT==============
      # name = "JetBrainsMono Nerd Font";
      name = "Go Mono for Powerline";
      # name = "Liberation Mono";
      # name = "Hack";
      # name = "Cousine for Powerline";
      # name = "Meslo LG M for Powerline";
      # name = "Go Mono for Powerline";
      # name-bold = "DejaVu Sans Mono";
    };
    settings = {
      background = "#000000";
      background_opacity = "0.95";
      confirm_os_window_close = 0;
      # cursor_shape = "beam";
      cursor_trail = "5";
      cursor_trail_decay = "0.20 0.5"; # X and Y decay
      cursor_trail_thickness = "1.2 1.2"; # X and Y thickness
      # Y: faster
      # cursor_trail = "6"; # number of ghost cursors
      # cursor_trail_decay = "0.20 0.08"; # fast fade in X/Y directions
      # cursor_trail_thickness = "1.2 1.2"; # default thickness

      # Ghostty settings:
      # vec4 TRAIL_COLOR = iCurrentCursorColor; // can change to eg: vec4(0.2, 0.6, 1.0, 0.5);
      # const float DURATION = 0.09; // in seconds
      # const float MAX_TRAIL_LENGTH = 0.3;
      # const float THRESHOLD_MIN_DISTANCE = 1.5; // min distance to show trail (units of cursor width)
      # const float BLUR = 2.0; // blur size in pixels (for antialiasing)
      #
      # // --- CONSTANTS for easing functions ---
      # const float PI = 3.14159265359;
      # const float C1_BACK = 1.70158;
      # const float C2_BACK = C1_BACK * 1.525;
      # const float C3_BACK = C1_BACK + 1.0;
      # const float C4_ELASTIC = (2.0 * PI) / 3.0;
      # const float C5_ELASTIC = (2.0 * PI) / 4.5;
      # const float SPRING_STIFFNESS = 9.0;
      # const float SPRING_DAMPING = 0.9;
      cursor_blink_interval = "0"; # disables blinking completely
    };
    keybindings = {
      "ctrl+shift+c" = "copy_to_clipboard";
      "ctrl+shift+v" = "paste_from_clipboard";
      "ctrl+shift+q" = "no_op"; # unbind close_tab
    };
  };



}
