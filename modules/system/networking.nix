{ config, lib, pkgs, ... }:

{
  # Networking configuration
  networking = {
    hostName = "iamanuragh";
    
    # Custom hosts entries
    extraHosts = ''
      127.0.0.1 oelms.local.com
      127.0.0.1 clientportal.local.com
      127.0.0.1 library.local.com
    '';
    
    # Firewall configuration
    firewall = {
      enable = true;
      allowedTCPPorts = [ 
        22    # SSH
        80    # HTTP
        443   # HTTPS
        3000  # Development servers
        3355  # Custom service
        8001  # Custom service
        9003  # Custom service
        19530 # Custom service
      ];
    };
    
    # Enable NetworkManager
    networkmanager.enable = true;
  };
  
  # Tailscale VPN
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
  };
}
