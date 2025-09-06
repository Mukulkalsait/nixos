# nbfc.nix
{ config, inputs, pkgs, ... }:
let myUser = "mukuldk";
in {
  environment.systemPackages = with pkgs; [ nbfc-linux ];

  # Create the config file in /etc
  environment.etc."nbfc/configs/predator_neo16_phn16-71.json" = {
    source = ./source_files/predator_neo16_phn16-71.json;
  };

  # Create symlink from nix store location to /etc location
  systemd.tmpfiles.rules = [
    "d ${pkgs.nbfc-linux}/share/nbfc 0755 root root -"
    "d ${pkgs.nbfc-linux}/share/nbfc/configs 0755 root root -"
    "L+ ${pkgs.nbfc-linux}/share/nbfc/configs/predator_neo16_phn16-71.json - - - - /etc/nbfc/configs/predator_neo16_phn16-71.json"
  ];

  systemd.services.nbfc_service = {
    enable = true;
    description = "NoteBook FanControl service";
    serviceConfig = {
      Type = "simple";
      ExecStart =
        "${pkgs.nbfc-linux}/bin/nbfc_service --config-file '/home/${myUser}/.config/nbfc.json'";
    };
    path = [ pkgs.kmod ];
    wantedBy = [ "multi-user.target" ];
    # Make sure tmpfiles service runs first
    after = [ "systemd-tmpfiles-setup.service" ];
    requires = [ "systemd-tmpfiles-setup.service" ];
  };
}
