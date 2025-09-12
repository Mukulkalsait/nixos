{ lib, config, pkgs, ... }: {
  # Ghostty
  programs.ghostty = {
    enable = true;
    package = pkgs.ghostty; # Ensure Ghostty is available in nixpkgs
    settings = {
      theme = "catppuccin-mocha"; # Matches Kitty's Catppuccin-Mocha
      font-family = "JetBrainsMono Nerd Font";
      font-size = 9;
      background = "#000000";
      background-opacity = 0.95;
      confirm-os-window-close = 0;
      # Cursor trail animation via shader
      custom-shader = "~/.config/ghostty/shaders/cursor_smear.glsl";
      custom-shader-animate = true;
      # Shader uniforms to mimic Kitty's cursor_trail_decay and thickness
      shader-uniform-cursor-trail-decay-x = 0.25;
      shader-uniform-cursor-trail-decay-y = 0.5;
      shader-uniform-cursor-trail-thickness-x = 1.0;
      shader-uniform-cursor-trail-thickness-y = 1.0;
      # Keybindings matching Kitty
      keybind = [
        "ctrl+shift+c=copy_to_clipboard"
        "ctrl+shift+v=paste_from_clipboard"
      ];
    };
  };

  # Ensure shader directory exists and fetch a cursor trail shader
  home.file.".config/ghostty/shaders/cursor_smear.glsl".source =
    ./sharers/cursor_smear.glsl;

}
