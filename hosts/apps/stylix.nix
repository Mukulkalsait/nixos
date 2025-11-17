# Y:  general styling.
{ pkgs, inputs, ... }: {
  imports = [ inputs.stylix.homeModules.stylix ];
  stylix.targets.kitty.enable = false;
  # stylix.targets.zen-browser.profileNames = [ "mukul" ];

  # IMP:  All fonts moved to system apps.

  home.packages = with pkgs; [
    dejavu_fonts
    jetbrains-mono
    # texlivePackages.hebrew-fonts

    noto-fonts
    # lohit-fonts
    # noto-fonts-lgc-plus
    noto-fonts-color-emoji
    noto-fonts # Marathi fonts
    # lohit-fonts.devnagari # Marathi fonts
    # ttf-indic-fonts # Marathi fonts

    font-awesome

    powerline-fonts
    powerline-symbols

    # (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })

    pkgs.nerd-fonts.symbols-only
    corefonts # Y:  Times New Roman, Arial (Microsoft Fonts)
  ];

  stylix = {
    enable = true;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
    # Y: OPTOINS
    # ls /nix/store/*base16-schemes*/share/themes <- run
    #gruvbox-dark-medium.yaml DEFAULT
    # tokyo-night-night.yaml
    # tokyo-night-night.yaml
    # tokyo-night-storm.yaml
    # tokyo-night-day.yaml
    # catppuccin-mocha.yaml
    # dracula.yaml
    # nord.yaml

    targets = {
      neovim.enable = false;
      waybar.enable = false;
      wofi.enable = false;
      hyprland.enable = false;
      hyprlock.enable = false;
    };

    cursor = {
      name = "DMZ-Black";
      size = 20;
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
        terminal = 8;
        applications = 8;
      };
    };

    iconTheme = {
      enable = true;
      package = pkgs.papirus-icon-theme;
      dark = "Papirus-Dark";
      light = "Papirus-Light";
    };

    # image = pkgs.fetchurl {
    #   url =
    #     "https://codeberg.org/lunik1/nixos-logo-gruvbox-wallpaper/raw/branch/master/png/gruvbox-dark-rainbow.png";
    #   sha256 = "036gqhbf6s5ddgvfbgn6iqbzgizssyf7820m5815b2gd748jw8zc";
    # };
  };
}
