{ config, pkgs, ... }:

{
  # Hyprland configuration files
  home.file = {
    # Main Hyprland configuration
    ".config/hypr/hyprland.conf".source = ../../config/hypr/hyprland.conf;
    
    # Secure environment template
    ".config/hypr/env.conf.example".source = ../../config/hypr/env.conf.example;
    
    # Hyprland related configs
    ".config/hypr/hypridle.conf".source = ../../config/hypr/hypridle.conf;
    ".config/hypr/hyprlock.conf".source = ../../config/hypr/hyprlock.conf;
    ".config/hypr/hyprpaper.conf".source = ../../config/hypr/hyprpaper.conf;
    
    # Wallpapers
    ".config/hypr/wal.jpg".source = ../../config/hypr/wal.jpg;
    ".config/hypr/wal.png".source = ../../config/hypr/wal.png;
    
    # Wofi configuration
    ".config/hypr/wofi-config".source = ../../config/hypr/wofi-config;
    ".config/hypr/wofi-dmenu-config".source = ../../config/hypr/wofi-dmenu-config;
    ".config/hypr/wofi-style.css".source = ../../config/hypr/wofi-style.css;
    ".config/hypr/wofi-dmenu-style.css".source = ../../config/hypr/wofi-dmenu-style.css;
    
    # Dunst configuration
    ".config/hypr/dunstrc".source = ../../config/hypr/dunstrc;
    
    # Scripts
    ".config/hypr/autostart.sh" = {
      source = ../../config/hypr/autostart.sh;
      executable = true;
    };
  };
  
  # Wayland environment variables for Hyprland
  home.sessionVariables = {
    # Wayland
    WAYLAND_DISPLAY = "wayland-0";
    QT_QPA_PLATFORM = "wayland;xcb";
    GDK_BACKEND = "wayland,x11";
    
    # XDG
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    
    # QT theming
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    
    # Mozilla
    MOZ_ENABLE_WAYLAND = "1";
    
    # SDL
    SDL_VIDEODRIVER = "wayland";
    
    # Java
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };
}
