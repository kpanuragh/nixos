{
  description = "NixOS configuration";

  inputs = {
    # Use nixos-unstable for latest packages, with option to pin stable releases
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    
    # home-manager, used for managing user configuration
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # Additional useful inputs
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # Your custom packages
    ollama-tui = {
      url = "github:kpanuragh/ollama-tui";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # Hardware optimization
    hardware.url = "github:nixos/nixos-hardware";
  };

  outputs = inputs@{ nixpkgs, nixpkgs-stable, home-manager, hardware, ollama-tui, hyprland, ... }: {
    nixosConfigurations = {
      # Change hostname to match your actual system
      iamanuragh = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { 
          inherit inputs; 
          pkgs-stable = import nixpkgs-stable {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
        };
        modules = [
          ./configuration.nix
          # Add hardware module only if needed for your specific hardware
          # hardware.nixosModules.common-pc-laptop # Uncomment if needed

          # make home-manager as a module of nixos
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.users.anuragh = import ./home.nix;
            home-manager.extraSpecialArgs = { inherit inputs; };
          }
        ];
      };
    };
  };
}
