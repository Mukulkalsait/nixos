# Y: Themes Settings
{ config, pkgs, inputs, zen-browser, ... }:
{
  gtk = {
    enable = true;
    iconTheme = { package = pkgs.papirus-icon-theme; name = "Papirus-Dark"; };
    theme = { package = pkgs.adw-gtk3; name = "adw-gtk3-dark"; };
    gtk3.extraConfig = { gtk-application-prefer-dark-theme = true; };
    gtk4.extraConfig = { gtk-application-prefer-dark-theme = true; };
  };
  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.name = "adwaita-dark";
  };



  home.packages = with pkgs; [

    # B: Fonts.
    noto-fonts # 800+ fonts all (hindi/marathi)
    noto-fonts-color-emoji
    font-awesome # way-bar and all
    corefonts # MS-office fonts

    # fonts with LIGATURE (=== !+ => -> |- =| |> )
    nerd-fonts.jetbrains-mono
    # nerd-fonts.cascadia-code MISSING
    nerd-fonts.iosevka
    nerd-fonts.victor-mono
    nerd-fonts.monaspace

    # dejavu_fonts
    # powerline-fonts
    # powerline-symbols
    # pkgs.nerd-fonts.symbols-only

    # B: GTK THEMES:
    adw-gtk3 # theme
    adwaita-icon-theme # GNOME default icons
    lxappearance
    # gnome-control-center # FullSettingPannel -> need to much changes in config.
  ];

}
