{ config, lib, pkgs, ... }:

{
  # System monitoring and debugging tools
  environment.systemPackages = with pkgs; [
    # System monitors
    btop            # Modern htop
    iotop           # I/O monitor
    iftop           # Network monitor
    sysstat         # System statistics
    lm_sensors      # Hardware sensors
    
    # Process and system analysis
    strace          # System call tracer
    ltrace          # Library call tracer
    lsof            # Open files
    procs           # Modern ps
    
    # System information
    neofetch        # System info
    pciutils        # PCI utilities
    usbutils        # USB utilities
    
    # Performance tools
    perf-tools      # Performance analysis
    
    # Hardware tools
    hdparm          # Hard drive utilities
  ];
}
