# Y: kitty.nix

{ lib, config, pkgs, ... }: {

  # Kitty
  programs.kitty = {
    enable = true;
    themeFile = "Catppuccin-Mocha";
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 7.5;
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
  };

}
