# Y: Home Packages

{ config, pkgs, inputs, zen-browser, ... }: {

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
    papirus-icon-theme # Themes pack for menu
    swww # Walpaper
    hyprshot # Screenshot
    hyprpicker # color picker tool
    libnotify # notification
    rofimoji # rofi Emojy picker
    rofi # MenuBar For Hyprland [ ROFI is the main now rofi-wayland is merged ]
    wl-clipboard # clipboard service
    cliphist # clipboard history manager
    wtype # FUN_3: wayland keyboard input= i am using "fcitx5" in /configuration.nix USE ONLY 1.
    # w3m # TUI browser : but Usefull For TUI IMAGE Rendering.

    # Y: Hardware Control |>
    pavucontrol # All audio IO gui tool very usefull.⭐
    playerctl # media controller

    # G: Android Relates |>
    android-tools # adb

    # ID: Terminal |>
    ghostty
    kitty
    zellij
    # tmux

    # R: NETWORKING |>
    rustscan # rust port scanner
    dig # network tool
    mtr # my trace route

    # B: CLI Essentilas |>
    bat # modern cat
    termshark #Wireshark cli
    fx # json viewer.
    sniffnet # cross platform monitor for Trafic 
    # nginx # Reverse Proxy Server

    # G: NIX-Related |>
    zsh-nix-shell # enable zsh in nixshell.
    nix-inspect # tell about packages in nix
    nix-search # nix Online Pkg Searcher
    nix-search-tv # another package search may be offline.

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


    # B: Desktop GUI apps:
    inputs.zen-browser.packages.${pkgs.system}.default
    mission-center # Task Manager
    libreoffice-fresh # community driven latest version fo libreoffice.
    scrcpy # Same for above
    vlc # Video Lan Converter
    # ardour # Music Produciton DAW
    graphviz # graph vitrulisatoin tool extreamly multypurpose. 

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

