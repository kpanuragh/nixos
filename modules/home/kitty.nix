{ config, pkgs, ... }:

{
  # Kitty configuration files
  home.file = {
    # Main Kitty configuration
    ".config/kitty/kitty.conf".source = ../../config/kitty/kitty.conf;
    
    # Theme configurations
    ".config/kitty/current-theme.conf".source = ../../config/kitty/current-theme.conf;
    ".config/kitty/dark-theme.auto.conf".source = ../../config/kitty/dark-theme.auto.conf;
    
    # Backup configuration (if needed)
    ".config/kitty/kitty.conf.bak".source = ../../config/kitty/kitty.conf.bak;
  };
  
  # Enable Kitty terminal
  programs.kitty = {
    enable = true;
    settings = {
      # Let the configuration file handle settings
      # This allows your existing kitty.conf to take precedence
    };
  };
}
