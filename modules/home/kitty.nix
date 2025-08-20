{ config, pkgs, ... }:

{
  # Kitty configuration files
  home.file = {
    # Main Kitty configuration
    ".config/kitty/kitty.conf".source = ../../config/kitty/kitty.conf;
    
    # Theme configurations
    ".config/kitty/current-theme.conf".source = ../../config/kitty/current-theme.conf;
    ".config/kitty/dark-theme.auto.conf".source = ../../config/kitty/dark-theme.auto.conf;
  };
  
  # Note: We don't use programs.kitty.enable here to avoid conflicts
  # Instead, we manage the configuration files directly through home.file
  # This gives us full control over your existing kitty.conf
}
