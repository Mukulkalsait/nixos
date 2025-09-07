# Y:  Neovim with home config.
{ config, pkgs, ... }: {
  programs.neovim = { enable = true; };

  # home.file.".config/nvim".source = /home/mukuldk/1_file/2_git_repos/nvim; 
  home.file.".config/nvim".source =
    config.lib.file.mkOutOfStoreSymlink "/home/mukuldk/1_file/2_git_repos/nvim";
}

#================================================================================================================================================
#  Pull your config directly from GIT into ~/.config/nvim
#
# home.file.".config/nvim".source = pkgs.fetchFromGitHub {
#   owner = "Mukulkalsait";
#   repo = "nvim";
#   rev = "main";  
#   sha256 = "sha256-2V0ZJKEZBZ9Wg3ZMklxwUk3KBiRkJ7paR3QQyXZXlRs=";  # Updated with correct hash
#   sha256 = "c9709fb51e20cadb46d0b6ca567bb34e19118dd4";  # This will fail but show you the correct hash
# };
#================================================================================================================================================

