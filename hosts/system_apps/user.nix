
{ config, pkgs, ... }:
{

  # imports = [ ./apps/yazi.nix  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.mukuldk = {
     isNormalUser = true;
     extraGroups = [ "wheel" "networkmanager" "audio" "video" ]; # Enable ‘sudo’ for the user.
     shell= pkgs.zsh;
     packages = with pkgs; [
    	zsh
     ];
   };

  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [

    # System Imp :
    greetd.tuigreet hyprland zsh wl-clipboard wlr-randr

    # Lang : 
    cargo gcc cmake python3 lua luarocks (python3.withPackages (ps: with ps; [ pynvim ])) 
    
    # CLI Essentilas:
    git gh wget curl jq fd ripgrep glib

    # CLI Utils : 
    p7zip 

    # Daily Drivers :
    neovim starship yazi 

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

	# package = inputs.hyprland.packages."$(pkgs.system)".hyprland; # hyprland-packages enabling?
  };

  # fonts.packages = with pkgs; [
  #   dejavu_fonts
  #   noto-fonts
  #   noto-fonts-cjk-sans
  #   noto-fonts-emoji
  #   nerd-fonts.fira-code
  #   nerd-fonts.jetbrains-mono
  #   nerd-fonts.hack
  # ];
  
  console = {
    font = "Lat2-Terminus16"; # good default
    packages = with pkgs; [ terminus_font ];
  };
}

