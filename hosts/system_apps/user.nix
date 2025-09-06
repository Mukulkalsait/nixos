{ config, pkgs, ... }: {

  imports = [ ./console.nix ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mukuldk = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "audio"
      "video"
    ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
    packages = with pkgs; [ zsh ];
  };

  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [

    # System Imp :
    greetd.tuigreet
    hyprland
    zsh
    wl-clipboard
    wlr-randr
    dive
    kdash

    # Lang : 
    cargo
    gcc
    gnumake
    cmake
    python3
    lua
    luarocks
    (python3.withPackages (ps: with ps; [ pynvim ]))
    uv

    # Kernal Related
    linuxPackages.kernel.dev
    pkg-config
    bc
    elfutils
    usbutils # for usb
    bolt # CLI =>Thunderbolt devices
    nbfc-linux # FAN Controller for linux.

    # CLI Essentilas:
    git
    gh
    wget
    curl
    jq
    fd
    ripgrep
    glib
    fzf
    fastfetch
    ripgrep

    # CLI Utils : 
    p7zip

    # Daily Drivers :
    neovim
    starship
    yazi
    pinta

    # TUI Utils : 
    btop

    # GPU: 
    nvtopPackages.full

  ];

  programs.zsh.enable = true;

  # HYPRLAND:
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # console = {
  #   # For smaller fonts, try these options:
  #   font = "${pkgs.terminus_font}/share/consolefonts/ter-112n.psf.gz"; # Small
  #   # font = "${pkgs.terminus_font}/share/consolefonts/ter-116n.psf.gz";  # Medium-small
  #   # font = "${pkgs.terminus_font}/share/consolefonts/ter-120n.psf.gz";  # Medium
  #   # font = "${pkgs.terminus_font}/share/consolefonts/ter-124n.psf.gz";  # Medium-large
  #   # font = "${pkgs.terminus_font}/share/consolefonts/ter-128n.psf.gz";  # Large
  #   # font = "${pkgs.terminus_font}/share/consolefonts/ter-132n.psf.gz";  # Extra large (what you had)
  #   packages = with pkgs; [ terminus_font ];
  #   colors = [
  #     # Define 16 colors for better TTY experience
  #     "1e1e2e" # base
  #     "f38ba8" # red
  #     "a6e3a1" # green
  #     "f9e2af" # yellow
  #     "89b4fa" # blue
  #     "cba6f7" # magenta
  #     "94e2d5" # cyan
  #     "bac2de" # white
  #     "45475a" # bright black
  #     "f38ba8" # bright red
  #     "a6e3a1" # bright green
  #     "f9e2af" # bright yellow
  #     "89b4fa" # bright blue
  #     "cba6f7" # bright magenta
  #     "94e2d5" # bright cyan
  #     "ffffff" # bright white
  #   ];
  # };
}

