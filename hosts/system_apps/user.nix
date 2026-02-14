# Y:  define the users
{ pkgs, ... }: {

  # B: Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mukuldk = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "audio"
      "video"
      "podman"
      "docker"
      # "incus"
      # "incus-admin"
    ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
    packages = with pkgs; [ zsh ];
  };

  # G: Lang & INPUT METHODS + input Selector
  i18n = {
    defaultLocale = "en_US.UTF-8"; # Input Method.
    inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [
        fcitx5-m17n
        fcitx5-gtk
      ];
    };
  };



  # IMP: SD MOUNNTING PERMENANT
  # fileSystems."/home/mukuldk/1_file/8_MOUNTINGS/SD_512" = {
  #   device = "UUID=9C33-6BBD";
  #   fsType = "exfat";
  #   options = [
  #     "uid=1000"
  #     "gid=100"
  #     "umask=0022"
  #     "nofail" # System boots even if SD is missing
  #     "x-systemd.automount" # Mounts only when accessed
  #     "x-systemd.device-timeout=5s" # timeout = 5s (default 90s)
  #     "noatime" # Stops updating “last accessed” timestamps
  #   ];
  # };


}

