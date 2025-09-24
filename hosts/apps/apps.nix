# Y: Home Packages

{ lib, config, pkgs, yazi, ... }: {
  # Y: this will put the .config_local/zellij into ~/.config/zellij
  home.file.".config/zellij".source = ./.config_local/zellij;

  # Minimal user packages (keep it simple for now)
  home.packages = with pkgs; [
    # CARD: OTHER app installation LOCATIONS |>
    # /etc/nixos/hosts/system_apps/nvidia.nix
    # /etc/nixos/hosts/apps/stylix.nix

    # DX: System Imp |>

    # Y: Hyprland + Plugins|>
    xdg-desktop-portal-gtk # desktop intigration (file manager, ss ,etc)
    xdg-desktop-portal-hyprland # same as above + hyprland
    rofi # MenuBar For Hyprland
    swww # Walpaper
    libnotify # notification
    hyprshot # Screenshot
    wtype # FUN_3: wayland keyboard input= i am using "fcitx5" in /configuration.nix USE ONLY 1.
    hyprpicker # color picker tool
    wev # input event check + debug, <keyboard, mouse>
    # w3m # TUI browser : but Usefull For TUI IMAGE Rendering.

    # Y: Hardware Control |>
    brightnessctl # brightness controller
    playerctl # media controller
    pavucontrol # All audio IO gui tool very usefull.⭐

    # Terminal:
    kitty
    zellij
    # tmux

    # DevOps
    kdash # TUI kuberneties dashboard.
    dive # TUI Docker Images Layers.
    lazydocker # TUI lazy Docker.

    # Media & essentials:
    ffmpeg-full # ffmpeg
    ffmpegthumbnailer # tuhmbnel creater
    mediainfo # media info tool.
    easyeffects # Poweramp EQ enspired Equaliser.
    pinta # D.Photo editor

    # CLI Utils:
    bat
    eza
    rustscan # rust port scanner
    dua # rust disk utility use " dua i " intereative.
    dust # Disk space shower.
    pv # pipe viwer = shows prograssbar when used with pype.
    # adbfs-rootless # adm-mount

    # Programing Languages:
    nodejs # node js
    bun # bun replacement for npm.
    uv # PIP replacement. python package /dependency manager.
    (python3.withPackages (ps: with ps; [ pynvim ])) # python + its packages.

    # ---- LSPs via Nix (stable + fragile ones) ----
    # lua-language-server
    # pyright
    # clang-tools
    #
    # nodePackages.typescript-language-server # TypeScript / JavaScript
    # nodePackages.vscode-langservers-extracted # HTML, CSS, JSON, ESLint
    # nodePackages."@tailwindcss/language-server" # Tailwind
    # phpPackages.php-codesniffer # PHP

    # Desktop apps:
    mpv
    obs-studio
    vlc
    # spotify
    # spicetify-cli
    mission-center
    # blender # B: blender tests 
    libreoffice-fresh # community driven latest version fo libreoffice.
    testdisk # Data recovery tool.

    papirus-icon-theme
    pcmanfm-qt

    # GITHUB APPS:
    # inputs.zen-browser.packages."${system}".specific

    # CLI utils: bc bottom brightnessctl git-graph grimblast  ntfs3g playerctl showmethekey silicon udisks ueberzugpp wtype yt-dlp 

    # Coding stuff: openjdk23 python311

    # Other: bemoji nix-prefetch-scripts
  ];

  qt = {
    enable = true;
    # platformTheme.name = "gtk";
    # style = {
    #   package = pkgs.adwaita-qt;
    #   name = "adwaita-dark";
    # };
  };

  home.sessionPath = [ "$HOME/.cargo/bin" ];
}

