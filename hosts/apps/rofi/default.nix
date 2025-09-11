# Y: Wayland app launcher.
{
  programs.rofi = {
    enable = true;
    theme = ./config.rasi;
  };

  # home.file.".config/rofi/config.rasi".source = ./config.rasi; # Y: the above programs.rofi.theme dose the same thing.
  home.file.".config/rofi/shared/colors.rasi".source = ./colors.rasi;
  home.file.".config/rofi/shared/fonts.rasi".source = ./fonts.rasi;
}
