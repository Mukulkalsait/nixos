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
}

# ❯ ls $(nix eval --raw nixpkgs#glibc.dev)/include/stdio.h


