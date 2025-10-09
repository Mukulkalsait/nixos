# Y: Home Paths
{ lib, config, pkgs, yazi, ... }: {
  home.sessionPath = [
    "$HOME/.cargo/bin"
    "$HOME/go/bin"
    "$HOME/.cache/.bun/bin"
  ];
}



