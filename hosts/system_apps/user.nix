# Y:  define the users
{ config, pkgs, ... }: {

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

}

