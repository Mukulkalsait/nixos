# Y: Starship Rust.
{ config, pkgs, lib, ... }: {
  programs.starship = {
    enable = true;
    settings = {
      pkgs.lib.importTOML = ./starship-grovebox.toml;
      # palette = lib.mkForce "catppuccin-latte";
    };
  };
}

