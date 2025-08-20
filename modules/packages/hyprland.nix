{ config, lib, pkgs, ... }:

{
  # Hyprland/Wayland specific packages
  environment.systemPackages = with pkgs; [
    # Window management and launchers
    wofi            # Application launcher
    fuzzel          # Alternative launcher
    
    # Wallpaper and theming
    hyprpaper       # Wallpaper daemon
    swww            # Animated wallpaper
    matugen         # Material theme generator
    
    # Session management
    hypridle        # Idle daemon
    hyprlock        # Screen locker
    
    # Screenshots and screen recording
    grimblast       # Screenshot tool
    grim            # Wayland screenshot
    slurp           # Screen area selector
    swappy          # Screenshot editor
    wf-recorder     # Screen recorder
    
    # System utilities
    pyprland        # Hyprland utilities
    brightnessctl   # Brightness control
    pavucontrol     # Audio control
    
    # Clipboard and notifications
    cliphist        # Clipboard manager
    wl-clipboard    # Wayland clipboard
    dunst           # Notification daemon
    libnotify       # Notification library
    
    # System integration
    hyprpolkitagent # Polkit agent
    
    # Display utilities
    hyprsunset      # Blue light filter
  ];
}
