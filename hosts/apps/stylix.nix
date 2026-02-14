# Y: General styling.
{ pkgs, inputs, ... }: {
  imports = [ inputs.stylix.homeModules.stylix ];

  stylix.targets.kitty.enable = false;
  stylix.targets.zen-browser.profileNames = [ "mukul" ];
  stylix.targets.neovim.enable = false;
  stylix.targets.waybar.enable = false;
  stylix.targets.wofi.enable = false;
  stylix.targets.hyprland.enable = false;
  stylix.targets.hyprlock.enable = false;
  stylix.targets.gtk.enable = true;


  # Let Stylix handle Qt/GTK theming automatically

  home.packages = with pkgs; [
    dejavu_fonts
    jetbrains-mono
    noto-fonts
    noto-fonts-color-emoji
    font-awesome
    powerline-fonts
    powerline-symbols
    pkgs.nerd-fonts.symbols-only
    corefonts

    nautilus # File manager
    gnome-control-center # Settings panel
    adwaita-icon-theme # GNOME default icons

  ];



  stylix = {
    enable = true;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";

    cursor = {
      name = "DMZ-Black";
      size = 24;
      package = pkgs.vanilla-dmz;
    };

    fonts = {
      emoji = {
        name = "Noto Color Emoji";
        package = pkgs.noto-fonts-color-emoji;
      };
      monospace = {
        name = "JetBrains Mono";
        package = pkgs.jetbrains-mono;
      };
      sansSerif = {
        name = "Noto Sans";
        package = pkgs.noto-fonts;
      };
      serif = {
        name = "Noto Serif";
        package = pkgs.noto-fonts;
      };
      sizes = {
        terminal = 9;
        applications = 10;
      };
    };

    icons = {
      enable = true;
      package = pkgs.papirus-icon-theme;
      dark = "Papirus-Dark";
      light = "Papirus-Light";
    };
  };

}
