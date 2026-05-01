# Y: envornment varialbes fro all session.
{ pkgs, ... }: {
  environment.variables = {
    # Y: USE THIS TEMPERORYLY
    # export LIBCLANG_PATH=$(nix eval --raw nixpkgs#llvmPackages.libclang.lib)/lib
    # export C_INCLUDE_PATH=$(nix eval --raw nixpkgs#glibc.dev)/include
    # # LD = "${pkgs.lld}/bin/ld.lld";
    # RUST_SRC_PATH = "${pkgs.rustPlatform.rustLibSrc}/library";

    # Languages
    CC = "${pkgs.gcc}/bin/gcc";
    # others
    EDITOR = "nvim";

  };

  # This Provides the defualt tmux env for both root and non root users. 
  # making seemlaes neovim + tmux setup possible in  root env
  security.sudo.extraConfig = ''
    Defaults env_keep += "TMUX TMUX_PANE XDG_CONFIG_HOME XDG_DATA_HOME XDG_STATE_HOME"
  '';
}

# ❯ ls $(nix eval --raw nixpkgs#glibc.dev)/include/stdio.h


