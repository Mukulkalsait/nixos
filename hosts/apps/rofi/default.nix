# Y: Wayland app launcher.
{
  programs.rofi = { enable = true; };

  home.file.".config/rofi/config.rasi".source = ./config.rasi;
  home.file.".config/rofi/shared/colors.rasi".source = ./colors.rasi;
  home.file.".config/rofi/shared/fonts.rasi".source = ./fonts.rasi;
}
