# newDockerfile.nix
{ pkgs, ... }:
let
  newDockerfile = pkgs.buildGoModule {
    pname = "new-dockerfile";
    version = "0.5.0";
    src = pkgs.fetchFromGitHub {
      owner = "flexstack";
      repo = "new-dockerfile";
      rev = "d6c1b0fb89e8335d83ce9ba1d690cd88e753a7bb";
      hash = "sha256-176p2MHcAYVlyjBgLREsm/3IF4Y4pzAEnIOmfwbEXII=";
    };
    vendorHash = null; # No vendored dependencies, so null is fine
    meta = {
      description = "A CLI tool to generate optimized Dockerfiles and .dockerignore files";
      homepage = "https://github.com/flexstack/new-dockerfile";
      license = pkgs.lib.licenses.mit; # Based on repo's LICENSE
      platforms = pkgs.lib.platforms.all;
    };
  };
in
{
  home.packages = [
    newDockerfile
  ];
}
