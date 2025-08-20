{ config, lib, pkgs, ... }:

{
  # Networking tools
  environment.systemPackages = with pkgs; [
    # Network diagnostics
    mtr             # Network diagnostic tool
    iperf3          # Network performance
    nmap            # Network scanner
    
    # DNS tools
    dnsutils        # dig, nslookup, etc.
    
    # Download tools
    aria2           # Download manager
    wget            # Web downloader
    curl            # HTTP client
    
    # Network utilities
    socat           # Socket utility
    ipcalc          # IP calculator
    ethtool         # Ethernet tool
    
    # SSH utilities
    sshpass         # SSH with password
  ];
}
