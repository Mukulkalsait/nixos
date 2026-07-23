{
  imports = [
    # Y: hyprlang config.
    # ./binds.nix
    # ./hypridle.nix
    # ./main.nix
    ##|  ./hyprlock.nix
    ##|  ./awww.nix

  ];

  # Hyprland-Internal_configs.
  home.file.".config/hypr/media".source = ./media;
  home.file.".config/hypr/scripts".source = ./scripts;

  # G: New Lua Config will be here.
  home.file.".config/hypr/hyprland.lua".source = ./hyprland.lua;
  home.file.".config/hypr/keybindings.lua".source = ./keybindings.lua;
}
