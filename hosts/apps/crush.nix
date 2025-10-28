{ lib, config, pkgs, ... }: {
  imports = [ <nur> ]; # this line ensures your NUR modules are seen

  programs.crush = {
    enable = true;
    settings = {
      # providers = { … };
      # lsp = { … };
      # options = { … };
    };
  };

  # DX: RUN THIS FIRST :
  # nix-channel --add https://github.com/nix-community/NUR/archive/main.tar.gz nur
  # nix-channel --update

}

