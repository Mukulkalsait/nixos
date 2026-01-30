# Y: Starship Rust.
{ config, pkgs, ... }: {
  programs.starship = {
    enable = true;
    settings = pkgs.lib.importTOML ./starship-powerline.toml;

  };
}

