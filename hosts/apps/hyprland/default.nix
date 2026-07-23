{
  imports = [
    # Y: hyprlang config.
    # ./binds.nix
    # ./hypridle.nix
    # ./main.nix
    ##|  ./hyprlock.nix
    ##|  ./awww.nix

    # G: New Lua Config will be here.
  ];

  # Hyprland-Internal_configs.
  home.file.".config/hypr/media".source = ./media;
  home.file.".config/hypr/scripts".source = ./scripts;

}
