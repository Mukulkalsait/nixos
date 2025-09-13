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
  programs.fontconfig.enable = true; # Enables font discovery for user fonts

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5Addons = with pkgs;
      [
        fcitx5-m17n # For Hindi via m17n library (supports phonetic input like ITRANS)
        # Alternative: fcitx5-googlepinyin  # If you prefer Google-style transliteration (works for Hindi too)
      ];
  };
  # i18n.inputMethod = {
  #   enabled = "fcitx5";
  #   fcitx5.addons = with pkgs; [
  #     fcitx5-m17n # transliteration (Hindi/Marathi)
  #     fcitx5-gtk # GTK apps (WPS, Firefox, etc.)
  #   ];
  # };

  # R: this above service is very important for marathi/hindi typing with EHGLIS keyboard.
  # its called as phonetic Typing.
  # we are using m17n engine to do this. 
  # Y: Configure.
  # Go to IBus Preferences → Input Method → Add → m17n:hi-transliteration (for Hindi) or m17n:mr-transliteration (for Marathi).
  # Now when you switch input method (usually Ctrl+Space), you can type like this:
  # Type: namaste → Output: नमस्ते
  # Type: bharat → Output: भारत
  # This works system-wide, including WPS Office.

}

