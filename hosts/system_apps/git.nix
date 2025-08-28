{ config, pkgs, ... }: {
  programs.git.enable = true;
  environment.etc."gitconfig".text = ''
    [user]
      name = Mukulkalsait
      email = mdk.121.72633.sg@gmail.com
    [core]
      editor = nvim
    [color]
      ui = auto
  '';
}

