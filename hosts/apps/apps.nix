# Y: Home Packages

{ lib, config, pkgs, yazi, ... }: {
  # Y: this will put the .config_local/zellij into ~/.config/zellij
  home.file.".config/zellij".source = ./.config_local/zellij;

  # Minimal user packages (keep it simple for now)
  home.packages = with pkgs; [
    # CARD: OTHER app installation LOCATIONS |>
    # /etc/nixos/hosts/system_apps/nvidia.nix => Gpu, kuda, Vaapi, OpenCL, Prime, STEAM
    # /etc/nixos/hosts/system_apps/virtualisation.nix => Docker and MiniKube
    # /etc/nixos/hosts/apps/stylix.nix =>
    # /etc/nixos/hosts/apps/neovim.nix => LSP's, Langs, npm packages.

    # DX: System Imp |>

    # Y: Hyprland + Plugins|>
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

    # Y: Lang (Programing)|>
    nodejs # node js
    go # go-lang
    php # php
    bun # bun replacement for npm.
    uv # PIP replacement. python package /dependency manager.
    (python3.withPackages (ps: with ps; [ pynvim ])) # python + its packages.

    # B: CLI Essentilas |>
    bat
    eza
    rustscan # rust port scanner


    # B: TUI |>
    dua # rust disk utility use " dua i " intereative.
    dust # Disk space shower.
    pv # pipe viwer = shows prograssbar when used with pype.
    # adbfs-rootless # adm-mount

    # ID: Terminal |>
    kitty
    zellij
    # tmux

    # TEST: DevOps |>
    kdash # TUI kuberneties dashboard.
    dive # TUI Docker Images Layers.
    lazydocker # TUI lazy Docker.

    # B: Media & essentials |>
    ffmpeg-full # ffmpeg
    ffmpegthumbnailer # tuhmbnel creater
    mediainfo # media info tool.
    easyeffects # Poweramp EQ enspired Equaliser.
    pinta # D.Photo editor

    # Desktop apps:
    mission-center
    libreoffice-fresh # community driven latest version fo libreoffice.
    obs-studio
    vlc
    ardour
    graphviz # graph vitrulisatoin tool extreamly multypurpose. 
    # davinci-resolve
    # libxcb # for davinci-resovle
    # testdisk # DIV: Data recovery tool.
    # blender  #      Blender tests 

    # mpv
    # spotify
    # spicetify-cli

    # DX: REFERENCES |>

    # CLI utils: bc bottom git-graph grimblast ntfs3g playerctl showmethekey silicon udisks ueberzugpp wtype yt-dlp 
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

}

