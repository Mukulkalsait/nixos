{ config, pkgs, inputs, nur, ... }: {
  # inputs.home-manager.nixosModules.default

  imports = [
    # apps
    ./apps
    inputs.zen-browser.homeModules.twilight
  ];

  home.username = "mukuldk";
  home.homeDirectory = "/home/mukuldk";
  home.stateVersion = "26.05";


  programs.home-manager.enable = true;

  # Y: ZEN Browser.
  programs.zen-browser = {
    enable = true;
    profiles.mukul = {
      id = 0;
      name = "mukul";
      isDefault = true;
    };
  };

  # enable XDG Support:
  xdg.enable = true;

  # default apps: 
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "x-scheme-handler/terminal" = [ "kitty.desktop" ];
      "text/plain" = [ "nvim.desktop" ];

      "video/mp4" = [ "mpv.desktop" ];
      "video/x-matroska" = [ "mpv.desktop" ];
      "video/webm" = [ "mpv.desktop" ];
      "video/quicktime" = [ "mpv.desktop" ];
    };
  };


}
