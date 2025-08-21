{ config, lib, pkgs, ... }:

{
  # Security hardening
  security = {
    rtkit.enable = true;
    polkit.enable = true;
    
    # Enable sudo with a reasonable timeout
    sudo = {
      enable = true;
      extraConfig = ''
        Defaults timestamp_timeout=30
        Defaults pwfeedback
      '';
    };
    
    # AppArmor for additional security
    apparmor = {
      enable = true;
      killUnconfinedConfinables = true;
    };
  };

  # Firewall configuration
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 ]; # SSH
    allowedUDPPorts = [ ];
  };

  # Fail2ban for SSH protection
  services.fail2ban = {
    enable = true;
    bantime = "24h";
    bantime-increment = {
      enable = true;
      multipliers = "1 2 4 8 16 32 64";
      maxtime = "168h";
      overalljails = true;
    };
  };

  # System-wide security kernel settings
  boot.kernel.sysctl = {
    # Network security
    "net.ipv4.conf.all.send_redirects" = false;
    "net.ipv4.conf.default.send_redirects" = false;
    "net.ipv4.conf.all.accept_redirects" = false;
    "net.ipv4.conf.default.accept_redirects" = false;
    "net.ipv4.conf.all.accept_source_route" = false;
    "net.ipv4.conf.default.accept_source_route" = false;
    
    # Memory protection
    "kernel.yama.ptrace_scope" = 1;
    "kernel.kptr_restrict" = 2;
    "kernel.dmesg_restrict" = 1;
  };
}
