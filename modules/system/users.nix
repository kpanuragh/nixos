{ config, lib, pkgs, ... }:

{
  # Security configuration
  security = {
    rtkit.enable = true;
    
    # Sudo configuration
    sudo = {
      enable = true;
      wheelNeedsPassword = false;
    };
    
    # Enhanced security
    apparmor.enable = true;
    polkit.enable = true;
  };
  
  # User management
  users.users.anuragh = {
    isNormalUser = true;
    description = "Anuragh";
    extraGroups = [ 
      "networkmanager" 
      "wheel" 
      "docker" 
      "adbusers" 
      "plugdev" 
    ];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };
  
  # Enable programs that need special permissions
  programs = {
    adb.enable = true;
    git.enable = true;
    zsh.enable = true;
  };
}
