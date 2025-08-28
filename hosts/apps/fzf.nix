{ lib, config, pkgs, ... }: {
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}

# programs.zoxide = {
# enable = true;
# enableZshIntegration = true; # provides `z` command without touching `cd`
# };

