{
  imports = [
    ./binds.nix
    ./hypridle.nix
    ./hyprlock.nix
    ./swww.nix
    ./main.nix
  ];

  # Hyprland-Internal_configs.
  home.file.".config/hypr/media".source = ./media;
  home.file.".config/hypr/scripts".source = ./scripts;

}
