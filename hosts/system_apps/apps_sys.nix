# Y:  Define the SYSTEM WIDE APPS
{ config, pkgs, lib, inputs, ... }: {

  environment.systemPackages = with pkgs; [

    # IMP: System Drivers |>
    inputs.wifitui.packages.${pkgs.system}.default # FLAKE:
    bluetuith # tui Bluetooth
    wiremix # another tui for audio:=
    pipewire # Controller for pipewire.
    pulseaudio # Controller for pulseaudio.
    lm_sensors # for sensors cmd or sensorD
    file # shows file tipe
    wl-clipboard # System wide clipboard
    cliphist # clipboard history manager
    brightnessctl # brightness controller
    # copyq # Clipboard manager

    # G: CLI Utils |>
    curl # URL trnasfer tool (HTTP/FTP/APIS)
    wget # HTTP FTP file downloader.
    zip # zip
    unzip # unzip
    zsh # shell.
    gh # Git hub
    jq # JSON parser.
    fd # Fast alternative for find
    fzf # fuzzy finder.
    ripgrep # Fast Test Search Tool | grep alternative?
    nvme-cli # check nvme health
    # tree-sitter # INSTALL WITH bun add -g tree-sitter-cli
    fastfetch # SYSTEM INFO
    p7zip # archiv/ unarchiv
    eza # Modern ls
    trash-cli # Recycle bean
    pkgs.sqlite # sqlite binary 

    # B: TUI Utils |>

    tree-sitter # system wide tree-sitter-cli
    neovim # D.Editor. # FLAKE: becomes nightly with flakes
    # pkgs.neovim-nightly
    imagemagick # neovim dependency for image conversitions
    mermaid-cli # ndovim dependency for markdown Diagrams
    yazi # D.FileManager
    starship # D.Prompt UI zsh prompt costumise.
    btop # Task manager.
    htop # Most imp.
    nvtopPackages.nvidia # GPU monitoring TUI

    # FUN_2: APPS |>
    mangohud # fps overlay
    # linuxPackages.nvidia_x11 # already present in nvidia drivers, dont overwrite
    steam # steam app itself
    protonup-ng # Steam Compatiblelity tool
    gamescope # full screen Window manager STEAM
    (pkgs.writeShellScriptBin "prime-run" ''
      #!/bin/sh
      __NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia "$@"
    '') # FLAKE:

    # G: Tradin Apps |>
    # tradingview

  ];

  programs.zsh.enable = true;

  # Y: HYPRLAND:
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Y: SSH
  programs.ssh = {
    startAgent = true; # (ssh-agent) => store ssh keys + Help you connect to Outer server
    # services.openssh.enable = true;  sshd.service
    # services.openssh.wantedBy = lib.mkForce []; shhd.service=> systemd
  };

}

