
# Packages

{ lib, config, pkgs, ...}:
{

 # Minimal user packages (keep it simple for now)
 home.packages = with pkgs; [

    
  # Window Mmanager: 
  libsForQt5.xwaylandvideobridge
  libnotify
  xdg-desktop-portal-gtk
  xdg-desktop-portal-hyprland
  hyprpicker 
  w3m wtype hyprpaper wl-clipboard 

  # Terminal:
  kitty 

  # Hardware Control:
  brightnessctl playerctl pavucontrol

  # Media & essentials:
  cliphist ffmpeg ffmpegthumbnailer  mediainfo

  # CLI Utils:
  bat eza fzf fastfetch ripgrep

  # Programing Languages:
  nodejs bun cargo 

  # LSPs: 
  python312Packages.rstcheck  # RUST
  nodePackages.typescript-language-server  # TS
  nodePackages.vscode-langservers-extracted nodePackages."@tailwindcss/language-server" 
  phpPackages.php-codesniffer # php

  # Desktop apps:
  mpv obs-studio

  # GITHUB APPS:
  # inputs.zen-browser.packages."${system}".specific

  # CLI utils: bc bottom brightnessctl git-graph grimblast  ntfs3g playerctl showmethekey silicon udisks ueberzugpp wtype yt-dlp 

  # Coding stuff: openjdk23 python311

  # Other: bemoji nix-prefetch-scripts
 ];
}

