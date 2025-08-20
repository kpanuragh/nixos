{ config, pkgs, ... }:

{
  # Waybar configuration files
  home.file = {
    # Main Waybar configuration
    ".config/waybar/config".source = ../../config/waybar/config;
    ".config/waybar/style.css".source = ../../config/waybar/style.css;
    
    # Waybar scripts
    ".config/waybar/waybar.sh" = {
      source = ../../config/waybar/waybar.sh;
      executable = true;
    };
    
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
    
    # Music visualization scripts
    ".config/waybar/music-visualizer.sh" = {
      source = ../../config/waybar/music-visualizer.sh;
      executable = true;
    };
    
    ".config/waybar/audio-visualizer.sh" = {
      source = ../../config/waybar/audio-visualizer.sh;
      executable = true;
    };
    
    ".config/waybar/simple-visualizer.sh" = {
      source = ../../config/waybar/simple-visualizer.sh;
      executable = true;
    };
    
    ".config/waybar/smooth-music.sh" = {
      source = ../../config/waybar/smooth-music.sh;
      executable = true;
    };
    
    ".config/waybar/scrolling-music.sh" = {
      source = ../../config/waybar/scrolling-music.sh;
      executable = true;
    };
    
    ".config/waybar/minimal-music.sh" = {
      source = ../../config/waybar/minimal-music.sh;
      executable = true;
    };
    
    # Waybar wallpaper
    ".config/waybar/wal.png".source = ../../config/waybar/wal.png;
  };
  
  # Enable Waybar
  programs.waybar = {
    enable = true;
    systemd.enable = true;
  };
}
