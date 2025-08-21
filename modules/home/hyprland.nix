{ config, pkgs, ... }:

{
  # Hyprland configuration - Full directory symbolic linking
  home.file = {
    # Link entire Hyprland configuration directory
    ".config/hypr" = {
      source = ../../config/hypr;
      recursive = true;
    };
    
    # Scripts that need to be executable
    ".config/hypr/autostart.sh" = {
      source = ../../config/hypr/autostart.sh;
      executable = true;
    };
  };

  # Create env.conf from example if it doesn't exist (for secrets)
  home.activation.createHyprEnvConf = ''
    if [ ! -f ~/.config/hypr/env.conf ]; then
      echo "Creating ~/.config/hypr/env.conf from example..."
      cp ~/.config/hypr/env.conf.example ~/.config/hypr/env.conf
      echo "Please edit ~/.config/hypr/env.conf with your actual API keys"
    fi
  '';
  
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
