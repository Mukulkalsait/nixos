# Y: Themes Settings
{ config, pkgs, inputs, zen-browser, ... }:
{
  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
      # name = "Papirus"; # light
      # name = "Papirus-Light"; # lighter variant
    };
    theme = {
      package = pkgs.adw-gtk3;
      name = "adw-gtk3-dark";
      # name = "adw-gtk3"; # light
    };
    gtk3.extraConfig = { gtk-application-prefer-dark-theme = true; };
    gtk4.extraConfig = { gtk-application-prefer-dark-theme = true; };
  };
  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.name = "adwaita-dark";
  };
  # IMP: check :  for themes and icons
  # ls ~/.nix-profile/share/themes/
  # ls /run/current-system/sw/share/icons/
  # or
  # nix eval nixpkgs#catppuccin-gtk.name

  home.packages = with pkgs; [

    # B: Fonts.
    noto-fonts # 800+ fonts all (hindi/marathi)
    noto-fonts-color-emoji
    font-awesome # way-bar and all
    corefonts # MS-office fonts

    # fonts with LIGATURE (=== !+ => -> |- =| |> )
    nerd-fonts.jetbrains-mono
    nerd-fonts.iosevka
    nerd-fonts.victor-mono
    nerd-fonts.monaspace

    # dejavu_fonts
    # powerline-fonts
    # powerline-symbols
    # pkgs.nerd-fonts.symbols-only

    # B: GTK THEMES:
    adw-gtk3 # material/gnome style
    catppuccin-gtk # very popular, multiple flavors
    graphite-gtk-theme # clean minimal dark
    orchis-theme # macos-ish
    tokyonight-gtk-theme # based on the famous neovim colorscheme

    # for Catppuccin
    # theme = {
    #   package = pkgs.catppuccin-gtk.override {
    #     accents = [ "blue" ];
    #     variant = "mocha"; # mocha=darkest, macchiato, frappe, latte=light
    #   };
    #   name = "catppuccin-mocha-blue-standard+default";
    # };

    # B: Icon Themes
    adwaita-icon-theme # GNOME default icons
    papirus-icon-theme # Themes pack for menu
    fluent-icon-theme
    numix-icon-theme-circle
    whitesur-icon-theme # macos style
    catppuccin-papirus-folders # catppuccin colored papirus

    # DX: APPS TO CHANGE THEMES: useless <immutable system>
    # gnome-control-center # FullSettingPannel
    # lxappearance # minimal 
  ];

}
