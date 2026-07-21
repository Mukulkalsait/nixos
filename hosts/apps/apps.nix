# Y: Home Packages

{ config, pkgs, inputs, ... }: {

  home.packages = with pkgs; [
    # OTHER app installation LOCATIONS |>
    # /etc/nixos/hosts/system_apps/nvidia.nix => Gpu, kuda, Vaapi, OpenCL, Prime, STEAM
    # /etc/nixos/hosts/system_apps/virtualisation.nix => Docker and MiniKube
    # /etc/nixos/hosts/apps/stylix.nix =>
    # /etc/nixos/hosts/apps/neovim.nix => LSP's, Langs, npm packages.

    # ----------------------------------------------------------------

    # DX: Hyprland + Plugins |>
    wev # input event check + debug, <keyboard, mouse>
    xdg-desktop-portal-gtk # desktop intigration (file manager, ss ,etc)
    xdg-desktop-portal-hyprland # same as above + hyprland
    # awww # Walpaper
    hyprshot # Screenshot
    hyprpicker # color picker tool
    libnotify # notification sender to everyone
    # rofimoji # rofi Emojy picker
    # rofi # MenuBar For Hyprland [ ROFI is the main now rofi-wayland is merged ]
    wl-clipboard # clipboard service
    cliphist # clipboard history manager
    wtype # FUN_3: wayland keyboard input= i am using "fcitx5" in /configuration.nix USE ONLY 1.
    # w3m # TUI browser : but Usefull For TUI IMAGE Rendering.

    # quickshell installation
    inputs.quickshell.packages.${pkgs.system}.default
    inputs.dms.packages.${pkgs.system}.default
    gtk-engine-murrine # Fix GTK theme warnings
    dgop # Optional: system monitoring for DMS


    # Y: Hardware Control |>
    pavucontrol # All audio IO gui tool very usefull.⭐
    playerctl # media controller

    # G: Android Relates |>
    android-tools # adb
    jmtpfs # Fuse filesystem for devices like Android
    libmtp # (Microsofts=MediatTrnasferProtocol) library
    # kdePackages.kdeconnect-kde # For KDE Plasma 6 (recommended)

    # ID: Terminal |>
    inputs.ghostty.packages.${pkgs.system}.default # FLAKE:
    # kitty
    # zellij
    nushell # best for http APIs checking.
    tmux

    # R: NETWORKING |>
    rustscan # rust port scanner
    dig # network tool
    mtr # my trace route
    net-tools # Basic network tools.
    netcat # nc
    sniffnet # cross platform monitor for Trafic 
    # wireshark # network monitoring tool
    termshark # Wireshark cli
    tcpdump # dumping netowrk data
    python313Packages.onvif-zeep # Onvif protocall (security  cameras) tool

    # B: CLI Essentilas |>
    bat # modern cat
    fx # json viewer.
    calcurse # Calender + take Manager Application.

    # G: NIX-Related |>
    zsh-nix-shell # enable zsh in nixshell.
    nix-inspect # tell about packages in nix
    nix-search # nix Online Pkg Searcher
    nix-search-tv # another package search may be offline.
    nix-tree # tui for everyting 

    # R: TUI |>
    dua # rust disk utility use " dua i " intereative.
    dust # Disk space shower.
    glow # TUI for markdown files 
    lazysql # db TUI
    tig # GIT Digger
    lnav # Log File NAVigator
    # bottom # TUI task manager BTOP is best
    # adbfs-rootless # adm-mount

    # B: Media & essentials |>
    ffmpeg-full # ffmpeg
    ffmpegthumbnailer # tuhmbnel creater
    mediainfo # media info tool.
    easyeffects # Poweramp EQ enspired Equaliser.
    sxiv # image previewer basic
    pinta # D.Photo editor
    shotcut # Video Editor
    nautilus # File manager

    # Ty: |> MUSIC PRODUCTION:
    ardour
    # lmms # does not work
    # Plugins for ardours
    # calf
    lsp-plugins
    x42-plugins
    zam-plugins
    sfizz
    # fluid-soundfont # not fou9nd
    # Linux Plogins for Ardour
    jack2
    alsa-utils


    # B: Desktop GUI apps:
    # inputs.zen-browser.packages.${pkgs.system}.default # FLAKE: this one is already in home.nix with profile settings.
    mission-center # Task Manager
    # libreoffice-fresh # community driven latest version fo libreoffice.
    onlyoffice-desktopeditors # alternate office tool
    scrcpy # Same for above
    vlc # Video Lan Converter
    graphviz # graph vitrulisatoin tool extreamly multypurpose. 
    # teamviewer

    # ID: Editors.
    # vscode
    # code-cursor

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


  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      obs-backgroundremoval
    ];
  };

  # DB perms for root sharing (optional, runs on switch)
  home.activation.setupCliphistDB = config.lib.dag.entryAfter [ "writeBoundary" ] ''
    DB_DIR="$HOME/.local/state/cliphist"
    mkdir -p "$DB_DIR"
    chmod 777 "$DB_DIR"
    [ -f "$DB_DIR/db" ] && chmod 666 "$DB_DIR/db"
  '';

}

