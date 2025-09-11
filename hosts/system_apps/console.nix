# Y:  TTY colors Config.
{ lib, config, pkgs, ... }: {

  console = {
    #   font = "Lat2-Terminus16";
    #   keyMap = "us";
    #   useXkbConfig = true; # use xkb.options in tty.
    font = "${pkgs.terminus_font}/share/consolefonts/ter-112n.psf.gz"; # Small
    # font = "${pkgs.terminus_font}/share/consolefonts/ter-116n.psf.gz";  # Medium-small
    # font = "${pkgs.terminus_font}/share/consolefonts/ter-120n.psf.gz";  # Medium
    # font = "${pkgs.terminus_font}/share/consolefonts/ter-124n.psf.gz";  # Medium-large
    # font = "${pkgs.terminus_font}/share/consolefonts/ter-128n.psf.gz";  # Large
    # font = "${pkgs.terminus_font}/share/consolefonts/ter-132n.psf.gz";  # Extra large (what you had)
    packages = with pkgs; [ terminus_font ];
    colors = [
      # Define 16 colors for better TTY experience
      "1e1e2e" # base
      "f38ba8" # red
      "a6e3a1" # green
      "f9e2af" # yellow
      "89b4fa" # blue
      "cba6f7" # magenta
      "94e2d5" # cyan
      "bac2de" # white
      "45475a" # bright black
      "f38ba8" # bright red
      "a6e3a1" # bright green
      "f9e2af" # bright yellow
      "89b4fa" # bright blue
      "cba6f7" # bright magenta
      "94e2d5" # bright cyan
      "ffffff" # bright white
    ];
  };

}
