# Y: DEV Services with no AUTO STARTING
{ config, pkgs, lib, ... }: {
  # B: MySql
  services.mysql = {
    enable = true;
    package = pkgs.mariadb; # or pkgs.mysql80 if you prefer
  };
  # B: NGINX
  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    # Disable default welcome by overriding unmatched servers
    appendHttpConfig = ''
      server {
        listen 80 default_server;
        listen [::]:80 default_server;
        server_name _;
        return 444;  # Non-existent response, no welcome
      }
    '';
    virtualHosts = {
      "localhost" = {
        default = true; # Make this the catch-all default
        root = "/home/mukuldk/1_file";
        listen = [{ addr = "0.0.0.0"; port = 80; }];
        locations."/" = {
          extraConfig = ''
            # Enable directory listing
            autoindex on;
            autoindex_exact_size off;
            autoindex_localtime on;
            # Disable caching completely for development
            add_header Cache-Control "no-store, no-cache, must-revalidate, proxy-revalidate, max-age=0";
            add_header Pragma "no-cache";
            add_header Expires "0";
            etag off;
            if_modified_since off;
            expires off;
          '';
        };
      };
      "127.0.0.1" = {
        root = "/home/mukuldk/1_file";
        listen = [{ addr = "127.0.0.1"; port = 80; }]; # Explicit for IP access
        locations."/" = {
          extraConfig = ''
            # Same as above...
            autoindex on;
            autoindex_exact_size off;
            autoindex_localtime on;
            add_header Cache-Control "no-store, no-cache, must-revalidate, proxy-revalidate, max-age=0";
            add_header Pragma "no-cache";
            add_header Expires "0";
            etag off;
            if_modified_since off;
            expires off;
          '';
        };
      };
    };
  };
  # DX: prevent any services.<name> from starting automatically at boot
  systemd.services.nginx.wantedBy = lib.mkForce [ ];
  systemd.services.mysql.wantedBy = lib.mkForce [ ];
}
