# Y: Home Packages

{ lib, config, pkgs, yazi, ... }: {
  # Y: this will put the .config_local/zellij into ~/.config/zellij
  home.file.".config/zellij".source = ./.config_local/zellij;

  # Minimal user packages (keep it simple for now)
  home.packages = with pkgs; [
    # IMP: OTHER app installation LOCATIONS.
    # /etc/nixos/hosts/system_apps/nvidia.nix
    # /etc/nixos/hosts/apps/stylix.nix

    # DX:TEMPERORY

    # Window Mmanager: 
    libnotify # notification
    xdg-desktop-portal-gtk # desktop intigration (file manager, ss ,etc)
    xdg-desktop-portal-hyprland # same as above + hyprland
    hyprpicker # color picker tool
    hyprshot # Screenshot
    w3m # TUI browser : but Usefull For TUI IMAGE Rendering.
    wtype # wayland keyboard input
    swww # Walpaper
    wev # input event check + debug, <keyboard, mouse>

    # Terminal:
    kitty
    zellij

    # DevOps
    kdash # TUI kuberneties dashboard.
    dive # TUI Docker Images Layers.
    lazydocker # TUI lazy Docker.

    # Hardware Control:
    brightnessctl # brightness controller
    playerctl # media controller
    pavucontrol # All audio IO gui tool very usefull.⭐

    # Media & essentials:
    ffmpeg # ffmpeg
    ffmpegthumbnailer # tuhmbnel creater
    mediainfo # media info tool.

    # CLI Utils:
    bat
    eza
    rustscan # rust port scanner
    dua # rust disk utility use " dua i " intereative.
    dust # Disk space shower.

    # Programing Languages:
    nodejs # node js
    bun # bun replacement for npm.
    uv # PIP replacement. python package /dependency manager.
    (python3.withPackages (ps: with ps; [ pynvim ])) # python + its packages.

    # ---- LSPs via Nix (stable + fragile ones) ----
    lua-language-server
    pyright
    clang-tools

    nodePackages.typescript-language-server # TypeScript / JavaScript
    nodePackages.vscode-langservers-extracted # HTML, CSS, JSON, ESLint
    nodePackages."@tailwindcss/language-server" # Tailwind
    phpPackages.php-codesniffer # PHP

    # Desktop apps:
    mpv
    obs-studio
    spotify
    spicetify-cli
    mission-center
    blender # blender tests

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

