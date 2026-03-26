# Y: Themes Settings
{ config, pkgs, inputs, zen-browser, ... }:
{
  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.catppuccin-papirus-folders;
      name = "Papirus-Dark"; # it still uses Papirus-Dark as the theme name
      # name = "Papirus"; # light
      # name = "Papirus-Light"; # lighter variant
    };
    theme = {
      # package = pkgs.adw-gtk3;
      # name = "adw-gtk3-dark";

      # === Current default (Adwaita-like) ===
      # package = pkgs.adw-gtk3;
      # name = "adw-gtk3-dark";

      # === Catppuccin (Highly Recommended) ===
      # package = pkgs.catppuccin-gtk.override {
      #   accents = [ "blue" ]; # try: blue, mauve, pink, teal, green, red, yellow
      #   variant = "mocha"; # mocha (darkest) > macchiato > frappe > latte (light)
      # };
      # name = "catppuccin-mocha-blue-standard";

      # === Graphite (Clean & Modern) ===
      # package = pkgs.graphite-gtk-theme;
      # name = "Graphite-Dark";

      # === Orchis (Elegant rounded) ===
      package = pkgs.orchis-theme;
      name = "Orchis-Dark";

      # === Tokyonight (Vibrant) ===
      # package = pkgs.tokyonight-gtk-theme;
      # name = "Tokyonight-Dark";

      # === Other good ones (uncomment one) ===
      # package = pkgs.catppuccin-gtk.override { accents = [ "mauve" ]; variant = "mocha"; };
      # name = "catppuccin-mocha-mauve-standard";

      # package = pkgs.graphite-gtk-theme;
      # name = "Graphite-Dark-compact";   # more compact version


    };
    gtk4.theme = config.gtk.theme;
    gtk3.extraConfig = { gtk-application-prefer-dark-theme = true; };
    gtk4.extraConfig = { gtk-application-prefer-dark-theme = true; };
  };
  qt = {
    enable = true;
    platformTheme.name = "gtk";
    # style.name = "adwaita-dark";
    style.name = "gtk2";
    # platformTheme.name = "qtct"; # or "qt5ct" / "kvantum"
    # style.name = "kvantum";
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
    # tokyonight-gtk-theme # based on the famous neovim colorscheme
    whitesur-icon-theme # macOS-like light

    # B: Icon Themes
    adwaita-icon-theme # GNOME default icons
    fluent-icon-theme
    numix-icon-theme-circle
    whitesur-icon-theme # macos style
    catppuccin-papirus-folders # catppuccin colored papirus

    # DX: APPS TO CHANGE THEMES: useless <immutable system>
    # gnome-control-center # FullSettingPannel
    # lxappearance # minimal 
  ];

}
