{ config, pkgs, ... }:

{
  # Waybar configuration - Full directory symbolic linking
  home.file = {
    # Link entire Waybar configuration directory
    ".config/waybar" = {
      source = ../../config/waybar;
      recursive = true;
    };
    
    # Override scripts to ensure they're executable
    ".config/waybar/restart-waybar.sh" = {
      source = ../../config/waybar/restart-waybar.sh;
      executable = true;
    };
    
    ".config/waybar/weather.sh" = {
      source = ../../config/waybar/weather.sh;
      executable = true;
    };
    
    ".config/waybar/power-menu.sh" = {
      source = ../../config/waybar/power-menu.sh;
      executable = true;
    };
    
    ".config/waybar/smooth-music.sh" = {
      source = ../../config/waybar/smooth-music.sh;
      executable = true;
    };
  };
  
  # Enable Waybar
  programs.waybar = {
    enable = true;
    systemd.enable = true;
  };
}
