# Y: envornment varialbes fro all session.
{ pkgs, ... }: {
  environment.variables = {
    EDITOR = "nvim";

    CC = "${pkgs.gcc}/bin/gcc";
    # LD = "${pkgs.lld}/bin/ld.lld"; # needed LLD in neovim.nix
    LIBCLANG_PATH = "${pkgs.llvmPackages.libclang.lib}/lib";

    # RUST_SRC_PATH = "${pkgs.rustPlatform.rustLibSrc}";
    RUST_SRC_PATH = "${pkgs.rustPlatform.rustLibSrc}/library"; # <-- UNCOMMENT/USE THIS (correct for std sources)
  };
}


