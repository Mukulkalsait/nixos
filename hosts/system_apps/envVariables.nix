# Y: envornment varialbes fro all session.
{ pkgs, ... }: {
  environment.variables = {
    EDITOR = "nvim";
    CC = "${pkgs.gcc}/bin/gcc";
    LD = "${pkgs.lld}/bin/ld.lld";
    # RUST_SRC_PATH = "${pkgs.rustPlatform.rustLibSrc}";
    RUST_SRC_PATH = "${pkgs.rustPlatform.rustLibSrc}/library"; # <-- UNCOMMENT/USE THIS (correct for std sources)
    # ... other variables
  };
}
