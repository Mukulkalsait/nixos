
# git.nix

{ lib, config, pkgs, ...}:
{

 # Git
 programs.git = {
  enable = true;
  userName = "Mukulkalsait";
  userEmail = "mdk.121.72633.sg@gmail.com";
 };
}

