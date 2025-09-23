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
      cursor_shape = "beam";
      cursor_trail = "3";
      cursor_trail_decay = "0.25 0.3"; # X and Y decay
      cursor_trail_thickness = "1.2 1.2"; # X and Y thickness
    };
    keybindings = {
      "ctrl+shift+c" = "copy_to_clipboard";
      "ctrl+shift+v" = "paste_from_clipboard";
      "ctrl+shift+q" = "no_op"; # unbind close_tab
    };
  };

}
