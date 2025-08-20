{ config, pkgs, ... }:

{
  # Kitty configuration - Full directory symbolic linking
  home.file = {
    # Link entire Kitty configuration directory
    ".config/kitty" = {
      source = ../../config/kitty;
      recursive = true;
    };
  };
  
  # Note: We don't use programs.kitty.enable here to avoid conflicts
  # Instead, we manage the configuration files directly through home.file
  # This gives us full control over your existing kitty.conf
}
