{ config, pkgs, ... }:

let
  # Wallpapers directory variable
  wallpapersDir = "${config.home.homeDirectory}/1_file/9_Walpapers/4k";
in {
  home.packages = with pkgs; [ swww ];

  # Expose options for Hyprland to use
  xsession.windowManager.hyprland.extraConfig = ''
    # Start swww
    exec-once = swww init

    # Set a random wallpaper on startup
    exec-once = swww img $(ls -1 ${wallpapersDir} | shuf -n1 | sed 's|^|${wallpapersDir}/|') --transition-type any --transition-duration 2

    # Keybinding to change wallpaper manually
    bind = $mainMod, W, exec, swww img $(ls -1 ${wallpapersDir} | shuf -n1 | sed 's|^|${wallpapersDir}/|') --transition-type any --transition-duration 2
  '';
}

