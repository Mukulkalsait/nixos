{ lib, config, pkgs, ... }: {
  # Ghostty
  programs.ghostty = {
    enable = true;
    package = pkgs.ghostty; # Ensure latest from nixpkgs
    settings = {
      theme = "catppuccin-mocha";
      font-family = "JetBrainsMono Nerd Font";
      font-size = 9;
      background = "#000000";
      background-opacity = 0.95;
      confirm-close-surface = false; # No close confirmation
      # Cursor trail via GLSL shader
      glsl-shader = "~/.config/ghostty/shaders/cursor_smear.glsl";
      # TERM for Kitty protocol compatibility
      term = "xterm-kitty";
      # Keybindings (uncommented, using correct syntax)
      keybind = [
        "ctrl+shift+c=copy_to_clipboard"
        "ctrl+shift+v=paste_from_clipboard"
      ];
    };
  };

  # Local shader file
  home.file.".config/ghostty/shaders/cursor_smear.glsl".source =
    ./shaders/cursor_smear.glsl;
}
