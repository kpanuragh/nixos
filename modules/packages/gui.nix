{ config, lib, pkgs, ... }:

{
  # Essential GUI applications
  environment.systemPackages = with pkgs; [
    # Browsers
    firefox
    
    # Terminal emulators
    kitty
    warp-terminal
    
    # Communication
    discord
    
    # Security
    bitwarden-cli
    
    # Utilities
    rpi-imager      # Raspberry Pi imager
    nwg-look        # GTK theme switcher
    
    # Entertainment
    hakuneko        # Manga downloader
  ];
}
