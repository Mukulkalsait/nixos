{
  imports = [
    ./binds.nix
    ./hypridle.nix
    # ./hyprlock.nix
    # ./awww.nix
    ./main.nix
  ];

  # Hyprland-Internal_configs.
  home.file.".config/hypr/media".source = ./media;
  home.file.".config/hypr/scripts".source = ./scripts;

}
