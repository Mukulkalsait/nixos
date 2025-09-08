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

  # IMP: SD MOUNNTING PERMENANT
  fileSystems."/home/mukuldk/1_file/8_MOUNTINGS/SD_512" = {
    device = "UUID=9C33-6BBD";
    fsType = "exfat";
    options = [ "uid=1000" "gid=100" "umask=0022" ];
  };

}

