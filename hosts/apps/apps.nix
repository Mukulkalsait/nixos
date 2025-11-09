# Y: Home Packages

{ pkgs, ... }: {

  home.packages = with pkgs; [
    # OTHER app installation LOCATIONS |>
    # /etc/nixos/hosts/system_apps/nvidia.nix => Gpu, kuda, Vaapi, OpenCL, Prime, STEAM
    # /etc/nixos/hosts/system_apps/virtualisation.nix => Docker and MiniKube
    # /etc/nixos/hosts/apps/stylix.nix =>
    # /etc/nixos/hosts/apps/neovim.nix => LSP's, Langs, npm packages.

    # DX: Hyprland + Plugins |>
    xdg-desktop-portal-gtk # desktop intigration (file manager, ss ,etc)
    xdg-desktop-portal-hyprland # same as above + hyprland
    pcmanfm-qt # FILE MANAGER WHICH TRIGGERS WHEN BROWSE BUTTON CLICKED
    rofi # MenuBar For Hyprland
    swww # Walpaper
    libnotify # notification
    papirus-icon-theme # Themes pack for menu
    hyprshot # Screenshot
    wtype # FUN_3: wayland keyboard input= i am using "fcitx5" in /configuration.nix USE ONLY 1.
    hyprpicker # color picker tool
    wev # input event check + debug, <keyboard, mouse>
    # w3m # TUI browser : but Usefull For TUI IMAGE Rendering.

    # Y: Hardware Control |>
    brightnessctl # brightness controller
    playerctl # media controller
    pavucontrol # All audio IO gui tool very usefull.⭐

    # Y: Lang (Programing) |>
    nodejs # node js
    go # go-lang
    bun # bun replacement for npm.
    (python3.withPackages (ps: with ps; [ pynvim ])) # python + its packages.
    uv # PIP replacement. python package /dependency manager.

    # ID: Terminal |>
    kitty
    zellij
    # tmux

    # B: CLI Essentilas |>
    nginx # Reverse Proxy Server
    bat # modern cat
    eza # Modern ls
    rustscan # rust port scanner
    dig # network tool
    mtr # my trace route
    bottom # TUI task manager

    # B: TUI |>
    dua # rust disk utility use " dua i " intereative.
    dust # Disk space shower.
    pv # pipe viwer = shows prograssbar when used with pype.
    # adbfs-rootless # adm-mount

    # TEST: DevOps |>
    dive # TUI Docker Images Layers.
    kdash # TUI kuberneties dashboard.

    # B: Media & essentials |>
    ffmpeg-full # ffmpeg
    ffmpegthumbnailer # tuhmbnel creater
    mediainfo # media info tool.
    easyeffects # Poweramp EQ enspired Equaliser.
    pinta # D.Photo editor
    # libsForQt5.kdeconnect-kde # kde connect for android connection
    # indicator-kdeconnect # Android connecti helper.

    # B: Desktop GUI apps:
    mission-center # Task Manager
    libreoffice-fresh # community driven latest version fo libreoffice.
    obs-studio # Screen recorder + Steamer
    vlc # Video Lan Converter
    ardour # Music Produciton DAW
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

  qt = {
    enable = true;
    # platformTheme.name = "gtk";
    # style = {
    #   package = pkgs.adwaita-qt;
    #   name = "adwaita-dark";
    # };
  };

  # Y: this will put the .config_local/zellij into ~/.config/zellij
  home.file.".config/zellij".source = ./.config_local/zellij;
}

