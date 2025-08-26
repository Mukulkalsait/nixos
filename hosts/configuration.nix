# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
	./hardware-configuration.nix
 	./system_apps/git.nix

	inputs.home-manager.nixosModules.default
    ];


  # Flake: 
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;
  nixpkgs.config.allowUnfree = true;

   networking.hostName = "PredatorNix"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
   networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
   time.timeZone = "Asia/Kolkata";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
   i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Configure keymap in X11

  # Enable CUPS to print documents.
   services.printing.enable = true;

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
   services.pipewire = {
     enable = true;
     alsa.enable = true;
     # alsa.support32bit = true; # does not exisists;
     pulse.enable = true;
     jack.enable = true;

   };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.mukuldk = {
     isNormalUser = true;
     extraGroups = [ "wheel" "networkmanager" "audio" "video" ]; # Enable ‘sudo’ for the user.
     shell= pkgs.zsh;
     packages = with pkgs; [
	zsh
     ];
   };


  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    # System Imp :
    greetd.tuigreet hyprland zsh wl-clipboard wlr-randr

    # Lang : 
    cargo gcc cmake
    
    # CLI Essentilas:
    git gh wget curl jq 

    # CLI Utils : 
    p7zip 

    # Daily Drivers :
    neovim starship yazi

    # TUI Utils : 
    btop 

  ];

  # programs.firefox.enable = true;
   programs.zsh.enable = true;

  services.greetd = {
    enable = true;
     settings = {
      default_session = {
        command = "tuigreet --time --remember --cmd Hyprland";
        user = "greeter";
      };
    };
  };


 # # # Security  (LockScreen)
 # # security.pam.services.greetd.enableGnomeKeyring = true;
 # # # Greetd: lockscreen
 # # services.greetd = {
 # #	enable = true;
 # #settings = {
 # #default_session = { 
 # #command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd Hyprland";
 # #user = "greeter";
 # #};
 # #};
 # #};

  # HYPRLAND:
   programs.hyprland = {
	enable = true;
	# package = inputs.hyprland.packages."$(pkgs.system)".hyprland; # hyprland-packages enabling?
	xwayland.enable = true;
   };

  # NVIDIA: 
   services.xserver.videoDrivers = [ "nvidia" ];
   hardware.graphics = { 
	enable = true;
	# enable32bit = true; # does not exisist.
   }; 
   hardware.nvidia = { 
	modesetting.enable = true;
	powerManagement.enable = false;
	powerManagement.finegrained = false;
	open = false;
	nvidiaSettings = true;
	package = config.boot.kernelPackages.nvidiaPackages.stable;
	forceFullCompositionPipeline = false;
  };


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?

}

