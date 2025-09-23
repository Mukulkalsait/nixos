# Y:  Define the SYSTEM WIDE APPS
{ config, pkgs, ... }: {

  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [

    # System Imp :
    greetd.tuigreet # TUI login manager.

    # nvidia-settings # imoprtant
    hyprland # wayland compositer.
    zsh # shell.
    wl-clipboard # clipboard.
    cliphist # clipboard history manager
    wlr-randr # wayland display manager tool.
    lm_sensors # for senseor of laptop.
    android-tools # ADB. android debuging.

    # Lang-supporter : 
    gnumake # Build automation tool (MakeFiles).
    cmake # Cross Platform build system generator.

    # Lang:
    gcc # GUN C compailer.
    cargo # rust package manager.
    rustup # latet rust {nightly}
    rust-analyzer # analyzer user latest nightly version
    lua # lua lang.
    luarocks # Lua package manager.

    # Kernal Related
    # Y: PREDATOR SENSE FUNCTIONALITY |>
    linuxPackages.kernel.dev # Kernel development headers/tools (needed for building modules).
    pkg-config # helper for compiling/linking libraris.
    bc # CLI calculater for Scripting features.
    elfutils # EBL librari working tools {kernal, perf, debuging}
    usbutils # lsusb + usb funcanilitys.
    bolt # Thunderbolt devices manager

    # CLI Essentilas:
    openssh
    git
    gh # Git hub
    wget # HTTP FTP file downloader.
    curl # URL trnasfer tool (HTTP/FTP/APIS)
    jq # JSON parser.
    fd # Fast alternative for find
    ripgrep # Fast Test Search Tool | grep alternative?
    glib # LOW lever system lib, {many app needed.}
    fzf # fuzzy finder.
    fastfetch # SYSTEM INFO

    # CLI Utils : 
    p7zip # archiv/ unarchiv

    # Daily Drivers :
    neovim # D>Editor.
    starship # zsh prompt costumise.
    yazi # D.FileManager

    # TUI Utils : 
    btop # Task manager.

    # GPU: 
    nvtopPackages.full # GPU monitoring TUI for NVIDIA/AMD/Intel GPUs

    # stress-ng # cpu stress tests
    mangohud # fps overlay
    nvidia-utils # nvidia-tool
    steam
    protonup
    (pkgs.writeShellScriptBin "prime-run" ''
      #!/bin/sh
      __NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia "$@"
    '')

  ];

  programs.zsh.enable = true;

  # HYPRLAND:
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  programs.ssh = {
    startAgent = true;
    # settings does not exisists:
    # settings = {     #   PasswordAuthentication = false; # use keys only
    #   PermitRootLogin = "no";
    # };
  };

}

