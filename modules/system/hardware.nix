{ config, lib, pkgs, ... }:

{
  # Hardware configuration
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    
    # RTL-SDR support
    rtl-sdr.enable = true;
  };
  
  # Bluetooth management
  services.blueman.enable = true;
  
  # System services
  services = {
    fwupd.enable = true; # Firmware updates
    upower.enable = true; # Power management
  };
  
  # Enable nix-ld for running unpatched binaries
  programs.nix-ld.enable = true;
}
