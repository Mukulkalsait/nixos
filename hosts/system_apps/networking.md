
## so commands 
```bash
resolvectl status
resolvectl dns  < wifiname> 1.1.1.1 8.8.8.8 
nmcli dev show | grep DNS 


// this is necessary to update the dns servers per network we connect.

nmcli devices 

nmcli connection modify "<tab>" IPv4.ignore-<tab>...auto no
nmcli connection modify "<tab>" IPv6.ignore-<tab>...auto no
nmcli conenction modify "<tab>" Ipv4.dns "1.1.1.1 1.0.0.1 8.8.8.8 8.0.0.8"

nmcli connection up "<tab "
nmcli connection down "<tab"

//// then check resolvctl status

nmcli dev show 

```

- are used here



--------------------------------------------------------------------------------------------------------------
  mukuldk ~  ♥ 15:15 
```sh
 resolvectl status
```

Global
           Protocols: +LLMNR +mDNS -DNSOverTLS DNSSEC=no/unsupported
    resolv.conf mode: stub
  Current DNS Server: 1.1.1.1 ========================================================================================================> THIS SHOW CONFIG BUT OVERWRITTING RESUALTS IN DIFFERENT 
         DNS Servers: 1.1.1.1 1.0.0.1 8.8.8.8 8.8.4.4
Fallback DNS Servers: 1.1.1.1#cloudflare-dns.com 8.8.8.8#dns.google 9.9.9.9#dns.quad9.net 1.0.0.1#cloudflare-dns.com 8.8.4.4#dns.google 149.112.112.112#dns.quad9.net 2606:4700:4700::1111#cloudflare-dns.com 2001:4860:4860::8888#dns.google 2620:fe::fe#dns.quad9.net
                      2606:4700:4700::1001#cloudflare-dns.com 2001:4860:4860::8844#dns.google 2620:fe::9#dns.quad9.net

Link 2 (enp109s0)
    Current Scopes: none
         Protocols: -DefaultRoute +LLMNR +mDNS -DNSOverTLS DNSSEC=no/unsupported
     Default Route: no

Link 3 (wlp0s20f3) ========================================================================================================================> MAIN WIFI MODULE
    Current Scopes: DNS LLMNR/IPv4 LLMNR/IPv6 mDNS/IPv4 mDNS/IPv6
         Protocols: +DefaultRoute +LLMNR +mDNS -DNSOverTLS DNSSEC=no/unsupported
Current DNS Server: 218.248.90.69 =============================================================================================================================== < "OVERWRITING deu to NMCLI"
       DNS Servers: 218.248.90.69 218.248.114.1
     Default Route: yes

=========================================================================================================================================== WITH THIS COMMAND WE CHANGE THE DNS TEMPERORALLY.

--------------------------------------------------------------------------------------------------------------

  mukuldk ~  ♥ 15:15 
```sh
 resolvectl dns wlp0s20f3 1.1.1.1 8.8.8.8
```

AUTHENTICATING FOR org.freedesktop.resolve1.set-dns-servers ====
Authentication is required to set DNS servers.
Authenticating as: mukuldk
Password:

==== AUTHENTICATION COMPLETE 

--------------------------------------------------------------------------------------------------------------
  mukuldk ~  ♥ 15:15  took 2s
```sh
 nmcli dev show
```

GENERAL.DEVICE:                         wlp0s20f3
GENERAL.TYPE:                           wifi
GENERAL.HWADDR:                         B0:DC:EF:DB:FE:1B
GENERAL.MTU:                            1500
GENERAL.STATE:                          100 (connected)
GENERAL.CONNECTION:                     OnePlus-Nord-CE3
GENERAL.CON-PATH:                       /org/freedesktop/NetworkManager/ActiveConnection/2
IP4.ADDRESS[1]:                         192.168.1.15/24
IP4.GATEWAY:                            192.168.1.1
IP4.ROUTE[1]:                           dst = 192.168.1.0/24, nh = 0.0.0.0, mt = 600
IP4.ROUTE[2]:                           dst = 0.0.0.0/0, nh = 192.168.1.1, mt = 600
IP4.DNS[1]:                             218.248.90.69 ===================================================================================================== OVERWRITING HAPPNING HERE
IP4.DNS[2]:                             218.248.114.1 ===================================================================================================== OVERWRITING HAPPNING HERE
IP6.ADDRESS[1]:                         fe80::40d6:413b:69f5:8d02/64
IP6.GATEWAY:                            --
IP6.ROUTE[1]:                           dst = fe80::/64, nh = ::, mt = 1024

GENERAL.DEVICE:                         lo
GENERAL.TYPE:                           loopback
GENERAL.HWADDR:                         00:00:00:00:00:00
GENERAL.MTU:                            65536
GENERAL.STATE:                          100 (connected (externally))
GENERAL.CONNECTION:                     lo
GENERAL.CON-PATH:                       /org/freedesktop/NetworkManager/ActiveConnection/1
IP4.ADDRESS[1]:                         127.0.0.1/8
IP4.GATEWAY:                            --
IP6.ADDRESS[1]:                         ::1/128
IP6.GATEWAY:                            --

GENERAL.DEVICE:                         p2p-dev-wlp0s20f3
GENERAL.TYPE:                           wifi-p2p
GENERAL.HWADDR:                         (unknown)
GENERAL.MTU:                            0
GENERAL.STATE:                          30 (disconnected)
GENERAL.CONNECTION:                     --
GENERAL.CON-PATH:                       --

GENERAL.DEVICE:                         enp109s0
GENERAL.TYPE:                           ethernet
GENERAL.HWADDR:                         74:D4:DD:0A:E3:A1
GENERAL.MTU:                            1500
GENERAL.STATE:                          20 (unavailable)
GENERAL.CONNECTION:                     --
GENERAL.CON-PATH:                       --
WIRED-PROPERTIES.CARRIER:               off
IP4.GATEWAY:                            --
IP6.GATEWAY:                            --

--------------------------------------------------------------------------------------------------------------
