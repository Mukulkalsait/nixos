# Y: Wayland app launcher.
{
  programs.rofi = {
    enable = true;
    settings = {
      allow_markup = true;
      allow_images = true;
      width = 350;
      height = 450;
    };
  };

  home.file.".config/rofi/style.css".source = ./style.css;
}
