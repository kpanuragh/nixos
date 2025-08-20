# NixOS Configuration - Main Entry Point
# This file imports all modular configurations

{ config, pkgs, ... }:

{
  imports = [
    # Hardware scan
    ./hardware-configuration.nix
    
    # System modules
    ./modules/system/boot.nix
    ./modules/system/nix.nix
    ./modules/system/networking.nix
    ./modules/system/users.nix
    ./modules/system/audio.nix
    ./modules/system/hardware.nix
    ./modules/system/virtualization.nix
    ./modules/system/locale.nix
    
    # Desktop modules
    ./modules/desktop/display.nix
    ./modules/desktop/gaming.nix
    ./modules/desktop/fonts.nix
    
    # Package modules
    ./modules/packages/development.nix
    ./modules/packages/hyprland.nix
    ./modules/packages/media.nix
    ./modules/packages/monitoring.nix
    ./modules/packages/networking.nix
    ./modules/packages/fileutils.nix
    ./modules/packages/gui.nix
    ./modules/packages/utilities.nix
    
    # Service modules
    ./modules/services/ai.nix
    ./modules/services/ssh.nix
  ];

  # System state version - DO NOT CHANGE
  system.stateVersion = "25.05";
}
