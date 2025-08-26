
{ config, pkgs, ... }:
{
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
    git gh wget curl jq fd ripgrep

    # CLI Utils : 
    p7zip 

    # Daily Drivers :
    neovim starship yazi

    # TUI Utils : 
    btop 

  ];

  programs.zsh.enable = true;

  # HYPRLAND:
  programs.hyprland = {
  	enable = true;
    xwayland.enable = true;

	# package = inputs.hyprland.packages."$(pkgs.system)".hyprland; # hyprland-packages enabling?
  };

}

