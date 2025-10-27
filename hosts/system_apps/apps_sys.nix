# Y:  Define the SYSTEM WIDE APPS
{ config, pkgs, ... }: {

  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    # CARD: OTHER app installation LOCATIONS |>
    # /etc/nixos/hosts/system_apps/nvidia.nix => Gpu, kuda, Vaapi, OpenCL, Prime, STEAM
    # /etc/nixos/hosts/system_apps/virtualisation.nix => Docker and MiniKube
    # /etc/nixos/hosts/apps/stylix.nix =>
    # /etc/nixos/hosts/apps/neovim.nix => LSP's, Langs, npm packages.

    # DX: System Imp |>
    greetd.tuigreet # TUI login manager.
    nix-prefetch-github # Y: RunToFindInfo: nix-prefetch-git --url https://github.com/0x7375646F/Linuwu-Sense --rev refs/heads/main


    # Y: Hyprland |>
    hyprland # wayland compositer.
    wl-clipboard # clipboard.
    wlr-randr # wayland display manager tool.
    # pipewire # to use Screen Sharing hone must needed.

    # Y: Hardware |>
    lm_sensors # for senseor of laptop.
    android-tools # ADB. android debuging.

    # Y: Lang |>
    # rustup # latet rust {nightly}
    gcc # GUN C compailer.
    binutils
    lld

    # rustup # latet rust {nightly}
    rustc # Add this for the Rust compiler
    cargo # rust package manager.
    clippy # 
    rust-analyzer # analyzer user latest nightly version
    rustPlatform.rustLibSrc # Add this for standard library source code

    lua # lua lang.
    luarocks # Lua package manager.
    nodejs # nodejs

    # DX: PREDATOR SENSE FUNCTIONALITY + Kernal Modifiers |>
    linuxPackages.kernel.dev # Kernel development headers/tools (needed for building modules).
    pkg-config # helper for compiling/linking libraris.
    bc # CLI calculater for Scripting features.
    elfutils # EBL librari working tools {kernal, perf, debuging}
    usbutils # lsusb + usb funcanilitys.
    bolt # Thunderbolt devices manager
    kmod # find
    flex # find

    # DX: PredatorNonSense |>
    evtest #

    # B: CLI Essentilas |>
    gnumake # Build automation tool (MakeFiles).
    cmake # Cross Platform build system generator.
    glib # LOW lever system lib, {many app needed.}

    git # git
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
    protonup # Steam Compatiblelity tool
    gamescope # full screen Window manager STEAM
    (pkgs.writeShellScriptBin "prime-run" ''
      #!/bin/sh
      __NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia "$@"
    '')

    # TAG: DISABELED Extras |>
    # stress-ng # cpu stress tests

    #Y: PredatorNonSense - Userspace Fan/RGB Control (NO KERNEL BUILD)
    # PredatorNonSense - Userspace Fan/RGB Control
    (
      let
        pns = pkgs.stdenv.mkDerivation {
          pname = "predator-nonsense";
          version = "unstable-2025-10-27";
          src = pkgs.fetchFromGitHub {
            owner = "kphanipavan";
            repo = "PredatorNonSense";
            rev = "main";
            sha256 = "sha256-N0bV0EivAKlUNUfc/8i/DyMJ01zselE8mo/jl3h9dK8="; #IMP: ← UPDATE THIS with nix-prefetch-github kphanipavan PredatorNonSense
            # sha256 = "sha256-1a2b3c4d5e6f7g8h9i0j1k2l3m4n5o6p7q8r9s0t1u2v3w4x5y6z"; # ← YOUR HASH
          };
          nativeBuildInputs = [ pkgs.makeWrapper ];
          buildInputs = [ pkgs.evtest ];
          installPhase = ''
            mkdir -p $out/bin $out/share/pns
            cp -r $src/* $out/share/pns/
            chmod +x $out/share/pns/PNS.sh
            makeWrapper $out/share/pns/PNS.sh $out/bin/pns \
              --prefix PATH : ${pkgs.lib.makeBinPath [ pkgs.evtest ]}
          '';
        };
      in
      pns
    )
    #

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

