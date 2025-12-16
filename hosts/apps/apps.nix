# Y: Home Packages

{ config, pkgs, ... }: {

  home.file.".config/zellij".source = ./.config_local/zellij; # this will put the .config_local/zellij into ~/.config/zellij
  home.packages = with pkgs; [
    # OTHER app installation LOCATIONS |>
    # /etc/nixos/hosts/system_apps/nvidia.nix => Gpu, kuda, Vaapi, OpenCL, Prime, STEAM
    # /etc/nixos/hosts/system_apps/virtualisation.nix => Docker and MiniKube
    # /etc/nixos/hosts/apps/stylix.nix =>
    # /etc/nixos/hosts/apps/neovim.nix => LSP's, Langs, npm packages.

    # DX: Hyprland + Plugins |>
    wev # input event check + debug, <keyboard, mouse>
    xdg-desktop-portal-gtk # desktop intigration (file manager, ss ,etc)
    xdg-desktop-portal-hyprland # same as above + hyprland
    pcmanfm-qt # FILE MANAGER WHICH TRIGGERS WHEN BROWSE BUTTON CLICKED
    papirus-icon-theme # Themes pack for menu
    swww # Walpaper
    hyprshot # Screenshot
    hyprpicker # color picker tool
    libnotify # notification
    rofi # MenuBar For Hyprland [ ROFI is the main now rofi-wayland is merged ]
    wl-clipboard # clipboard service
    cliphist # clipboard history manager
    wtype # FUN_3: wayland keyboard input= i am using "fcitx5" in /configuration.nix USE ONLY 1.
    # w3m # TUI browser : but Usefull For TUI IMAGE Rendering.

    # Y: Hardware Control |>
    brightnessctl # brightness controller
    playerctl # media controller
    pavucontrol # All audio IO gui tool very usefull.⭐

    # Y: Lang (Programing) |>
    nodejs # node js
    go # go-lang
    php # php
    bun # bun replacement for npm.
    (python3.withPackages (ps: with ps; [ pynvim ])) # python + its packages.
    uv # PIP replacement. python package /dependency manager.

    # ID: Terminal |>
    kitty
    zellij
    vscode
    code-cursor
    # tmux

    # B: CLI Essentilas |>
    nginx # Reverse Proxy Server
    bat # modern cat
    eza # Modern ls
    rustscan # rust port scanner
    dig # network tool
    mtr # my trace route
    bottom # TUI task manager
    lazysql # db TUI

    # G: NIX-Related |>
    zsh-nix-shell # enable zsh in nixshell.
    nix-inspect # tell about packages in nix
    nix-search # nix Online Pkg Searcher
    nix-search-tv # another package search may be offline.

    # B: TUI |>
    dua # rust disk utility use " dua i " intereative.
    dust # Disk space shower.
    pv # pipe viwer = shows prograssbar when used with pype.
    # adbfs-rootless # adm-mount

    # TEST: DevOps |>
    dive # TUI Docker Images Layers.
    kdash # TUI kuberneties dashboard.
    # terraform-versions."1.9.8" # Terraform with version 

    # B: Media & essentials |>
    ffmpeg-full # ffmpeg
    ffmpegthumbnailer # tuhmbnel creater
    mediainfo # media info tool.
    easyeffects # Poweramp EQ enspired Equaliser.
    pinta # D.Photo editor

    # G: Android Relates |>
    android-tools # adb
    # libsForQt5.kdeconnect-kde # kde connect for android connection
    # indicator-kdeconnect # Android connecti helper.

    # B: Desktop GUI apps:
    mission-center # Task Manager
    libreoffice-fresh # community driven latest version fo libreoffice.
    obs-studio # Screen recorder + Steamer
    scrcpy # Same for above
    obs-studio-plugins.backgroundremoval # to remove background 
    # obs-studio-plugins.droidcam-obs # To connect android camera directly 
    vlc # Video Lan Converter
    # ardour # Music Produciton DAW
    graphviz # graph vitrulisatoin tool extreamly multypurpose. 


    # TAG: REFERENCES |>
    # anydesk # desktop Connection Creater
    # davinci-resolve # Best Video editors
    # libxcb # for davinci-resovle
    # testdisk # Data recovery tool.
    # blender  # Blender tests 
    # stress-ng # cpu stress tests

    # REMFERENCE |>
    # CLI utils: bc bottom git-graph grimblast ntfs3g playerctl showmethekey silicon udisks ueberzugpp wtype yt-dlp 
    # Coding stuff: openjdk23 python311
    # Other: bemoji nix-prefetch-scripts mpv spotify spicetify-cli
  ];

  # Y:  MenuBar For Hyprland
  # programs.rofi = {
  #   enable = true;
  #   package = pkgs.rofi-wayland;
  # };

  qt = {
    enable = true;
    # platformTheme.name = "gtk";
    # style = {
    #   package = pkgs.adwaita-qt;
    #   name = "adwaita-dark";
    # };
  };

  # Y: Clipboard Config
  systemd.user.services.cliphist-watcher = {
    Unit = {
      Description = "Cliphist Wayland Clipboard Watcher";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.wl-clipboard}/bin/wl-paste --watch ${pkgs.cliphist}/bin/cliphist store";
      Restart = "always";
      RestartSec = 5;
    };
  };

  # DB perms for root sharing (optional, runs on switch)
  home.activation.setupCliphistDB = config.lib.dag.entryAfter [ "writeBoundary" ] ''
    DB_DIR="$HOME/.local/state/cliphist"
    mkdir -p "$DB_DIR"
    chmod 777 "$DB_DIR"
    [ -f "$DB_DIR/db" ] && chmod 666 "$DB_DIR/db"
  '';

}

