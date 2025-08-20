{ config, lib, pkgs, ... }:

{
  # Nix daemon and flakes configuration
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      builders-use-substitutes = true;
      max-jobs = "auto";
      cores = 0; # Use all available cores
      
      # Binary caches for faster downloads
      substituters = [
        "https://cache.nixos.org/"
        "https://nix-community.cachix.org"
      ];
      
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
    
    # Automatic garbage collection
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
    
    # Automatic system optimization
    optimise = {
      automatic = true;
      dates = [ "03:45" ];
    };
  };
  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
