# Y:  Define the SYSTEM WIDE APPS
{ config, pkgs, lib, inputs, ... }: {

  environment.systemPackages = with pkgs; [

    # IMP: System Drivers |>
    bluetuith # tui Bluetooth
    wiremix # another tui for audio:=
    inputs.wifitui.packages.${pkgs.system}.default # Y :WIFITUI
    pipewire # Controller for pipewire.
    pulseaudio # Controller for pulseaudio.
    lm_sensors # for sensors cmd or sensorD
    file # shows file tipe
    wl-clipboard # System wide clipboard
    cliphist # clipboard history manager
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
    tree-sitter # treesitter for neovim
    fastfetch # SYSTEM INFO
    p7zip # archiv/ unarchiv
    eza # Modern ls

    # B: TUI Utils |>
    yazi # D.FileManager
    neovim # D.Editor.
    starship # D.Prompt UI zsh prompt costumise.
    btop # Task manager.
    htop # Most imp.
    nvtopPackages.nvidia # GPU monitoring TUI

    # FUN_2: APPS |>
    mangohud # fps overlay
    linuxPackages.nvidia_x11
    steam # steam app itself
    protonup-ng # Steam Compatiblelity tool
    gamescope # full screen Window manager STEAM
    (pkgs.writeShellScriptBin "prime-run" ''
      #!/bin/sh
      __NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia "$@"
    '')

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

