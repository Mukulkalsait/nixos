{ config, pkgs, ... }: {
  programs.neovim = {
    enable = true;
    # package = pkgs.neovim; # orignal
    # package = pkgs.neovim-nightly; # we have to pass it from flakes. 
    # Do not use extraConfig here, instead point to your repo
  };

  # Pull your config directly from git into ~/.config/nvim
  # home.file.".config/nvim".source = /home/mukuldk/1_file/2_git_repos/nvim; 
  home.file.".config/nvim".source =
    config.lib.file.mkOutOfStoreSymlink "/home/mukuldk/1_file/2_git_repos/nvim";

  home.packages = with pkgs;
    [
      wl-clipboard # For Wayland/Hyprland clipboard support
      # xclip         # Fallback for X11
    ];
  # home.file.".config/nvim".source = pkgs.fetchFromGitHub {
  #   owner = "Mukulkalsait";
  #   repo = "nvim";
  #   rev = "main";
  #   sha256 = "sha256-2V0ZJKEZBZ9Wg3ZMklxwUk3KBiRkJ7paR3QQyXZXlRs=";  # Updated with correct hash
  # };

  # home.file.".config/nvim".source = pkgs.fetchFromGitHub {
  #   owner = "Mukulkalsait";
  #   repo = "nvim";
  #   rev = "main";  
  #   sha256 = "sha256-2V0ZJKEZBZ9Wg3ZMklxwUk3KBiRkJ7paR3QQyXZXlRs=";  # Updated with correct hash
  #   sha256 = "c9709fb51e20cadb46d0b6ca567bb34e19118dd4";  # This will fail but show you the correct hash
  # };

}

