# Y:  Define the SYSTEM WIDE APPS
{ config, pkgs, lib, ... }: {

  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    gh # Git hub
    wget # HTTP FTP file downloader.
    curl # URL trnasfer tool (HTTP/FTP/APIS)
    file # shows file tipe
    cliphist # clipboard history manager
    zip # zip
    unzip # unzip
    zsh # shell.
    openssh # ssh client.
    mtr # my traceroute.

    # B: CLI Utils |>
    jq # JSON parser.
    fd # Fast alternative for find
    fzf # fuzzy finder.
    ripgrep # Fast Test Search Tool | grep alternative?
    tree-sitter # treesitter for neovim
    fastfetch # SYSTEM INFO
    p7zip # archiv/ unarchiv

    # B: Daily Drivers |>
    yazi # D.FileManager
    neovim # D.Editor.
    starship # D.Prompt UI zsh prompt costumise.

    # B: TUI Utils |>
    btop # Task manager.
    nvtopPackages.nvidia # G: GPU monitoring TUI Specific for Nvidia GPUs SMALLER
    # nvtopPackages.full # GPU monitoring TUI for NVIDIA/AMD/Intel GPUs LAEGER


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

    # TAG: DISABELED Extras |>
    # stress-ng # cpu stress tests

  ];

  programs.zsh.enable = true;

  # HYPRLAND:
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  programs.ssh = {
    startAgent = true; # local background process (ssh-agent) => store ssh keys + Help you connect to Outer server
    # services.openssh.enable = true; # DX: starts => sshd.service + Open port 22 + Let others connect to your pc.
    # services.openssh.wantedBy = lib.mkForce []; Y: thsi will add the service but "WILL NOT START AT BOOT".

  };

  # Y: kde connect valent app pluign added.
  programs.kdeconnect = {
    enable = true;
    package = pkgs.valent;
  };


}

