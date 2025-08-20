{ config, lib, pkgs, ... }:

{
  # Bootloader configuration
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    
    # Optimized kernel parameters
    kernelParams = [
      "quiet"
      "splash"
      "loglevel=3"
      "systemd.show_status=auto"
      "rd.udev.log_level=3"
    ];
    
    # Enable zram for better memory management
    # Note: This will be moved to a separate module in newer NixOS versions
  };
  
  # ZRAM configuration (better than traditional swap)
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
  };
}
