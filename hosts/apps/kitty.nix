# Y: kitty.nix

{ lib, config, pkgs, ... }: {

  # Kitty
  programs.kitty = {
    enable = true;
    themeFile = "Catppuccin-Mocha";
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 9;
    };
    settings = {
      background = "#000000";
      background_opacity = "0.95";
      confirm_os_window_close = 0;
      # cursor_shape = "beam";
      cursor_trail = "3";
      cursor_trail_decay = "0.20 0.5"; # X and Y decay
      cursor_trail_thickness = "1.2 1.2"; # X and Y thickness
      # Y: faster
      # cursor_trail = "6"; # number of ghost cursors
      # cursor_trail_decay = "0.20 0.08"; # fast fade in X/Y directions
      # cursor_trail_thickness = "1.2 1.2"; # default thickness
      cursor_blink_interval = "0"; # disables blinking completely
    };
    keybindings = {
      "ctrl+shift+c" = "copy_to_clipboard";
      "ctrl+shift+v" = "paste_from_clipboard";
      "ctrl+shift+q" = "no_op"; # unbind close_tab
    };

    colors = {
      bright_black = "#8a8a8a"; # color8 equivalent
      bright_red = "#c14a4a"; # color9
      bright_green = "#6a9955"; # color10
      bright_yellow = "#b07a00"; # color11
      bright_blue = "#4078b8"; # color12
      bright_magenta = "#a0316b"; # color13
      bright_cyan = "#0f7a8a"; # color14 (anti-whitish)
      bright_white = "#8a8a8a"; # color15
    };
  };



}
