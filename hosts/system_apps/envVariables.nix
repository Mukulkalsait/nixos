# Y: envornment varialbes fro all session.
{ pkgs, ... }: {
  environment.variables = {
    CC = "${pkgs.gcc}/bin/gcc";
    LD = "${pkgs.lld}/bin/ld.lld";
    RUST_SRC_PATH = "${pkgs.rustPlatform.rustLibSrc}/library"; # Use rustPlatform.rustLibSrc for std source
    # ... other variables
  };
}
