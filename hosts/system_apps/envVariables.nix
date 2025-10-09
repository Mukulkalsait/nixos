# Y: envornment varialbes fro all session.
{ pkgs, ... }: {
  environment.variables = {
    # CC = "${pkgs.gcc}/bin/gcc";
    LD = "${pkgs.lld}/bin/ld.lld";
    RUST_SRC_PATH = "${pkgs.rust-src}/lib/rustlib/src/rust/library"; # For rust-analyzer
    # ... other variables
  };
}
