# Y: Home Packages

{ lib, config, pkgs, yazi, ... }: {
  home.sessionPath = [
    "$HOME/.cargo/bin"
    "$HOME/go/bin"
  ];
}

