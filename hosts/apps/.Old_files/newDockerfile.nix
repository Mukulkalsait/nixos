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
    # Use -mod=mod to ignore vendor/ and fetch from go.mod
    modArgs = [ "-mod=mod" ];
    # Calculated vendorHash for dependencies
    vendorHash = "sha256-vX5k0L7Kx/0e+FtF9y4zT0z3z5y6z7z8z9z0z1z2z3z4="; # Replace with correct hash
    meta = {
      description = "A CLI tool to generate optimized Dockerfiles and .dockerignore files";
      homepage = "https://github.com/flexstack/new-dockerfile";
      license = pkgs.lib.licenses.mit;
      platforms = pkgs.lib.platforms.all;
    };
  };
in
{
  home.packages = [
    newDockerfile
    # Other packages (e.g., pkgs.go, pkgs.docker)
  ];
}
