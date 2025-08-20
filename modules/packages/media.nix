{ config, lib, pkgs, ... }:

{
  # Media and entertainment packages
  environment.systemPackages = with pkgs; [
    # Media players and tools
    mpvpaper        # Video wallpaper
    ffmpeg          # Media converter
    
    # Audio tools
    cava            # Audio visualizer
    spotify-player  # Terminal Spotify client
    playerctl       # Media player control
    pulseaudio      # Audio utilities
    
    # Image processing
    imagemagick     # Image manipulation
    
    # Graphics and theming
    nordzy-cursor-theme
    adwaita-icon-theme
    arc-theme
    comixcursors
    gnome-themes-extra
    papirus-icon-theme
  ];
}
