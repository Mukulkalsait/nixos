# Y:  Firewall settings
{ ... }: {

  networking.firewall = {
    enable = true;

    # Individual ports opening          G: 
    # allowedTCPPorts = [ 5173 4000 ]; 
    # allowedUDPPorts = [ 5173 4000 ]; 

    allowedTCPPortRanges = [
      { from = 1714; to = 1764; } # Open ports in the firewall for Valent / KDE Connect
      # { from = 5173; to = 5183; } Y: we can add another like this 
    ];
    allowedUDPPortRanges = [
      { from = 1714; to = 1764; } # Open ports in the firewall for Valent / KDE Connect
    ];
    allowPing = true;


  };

}



