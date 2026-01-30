# Y: Starship Rust.
{ config, pkgs, lib, ... }: {
  programs.starship = {
    enable = true;
    settings = {
      pkgs.lib.importTOML = ./starship-tokyonight.toml;
      # palette = lib.mkForce "catppuccin-latte";
    };
  };
}

