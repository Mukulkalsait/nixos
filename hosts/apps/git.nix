# Y : systemwide git config
{ config, pkgs, ... }: {
  programs.git = {
    enable = true;
    userName = "Mukulkalsait";
    userEmail = "mdk.121.72633.sg@gmail.com";
    signing = {
      key = null;
      signByDefault = false;
    };
  };
}

# programs.git.enable = true;
# environment.etc."gitconfig".text = ''
#   [user]
#     name = 
#     email = 
#   [core]
#     editor = nvim
#   [color]
#     ui = auto
# '';
