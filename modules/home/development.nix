{ config, pkgs, ... }:

{
  # Configure direnv for automatic environment loading
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  # Development environments and tools (user-specific)
  home.packages = with pkgs; [
    # Language-specific tools (user-specific versions)
    cargo # Rust package manager (user-specific)
    
    # Version control tools (git config is in separate module)
    git-lfs
    
    # Containers and virtualization (user-specific)
    podman-compose

    
    # Database tools (user-specific)
    postgresql # Client tools
    
    # Networking and API tools (user-specific)
    httpie
    postman
    
    # Note: Removed duplicates that are in system packages:
    # - docker-compose, gh (in system/development.nix)
    # - cmake, gnumake, pkg-config (in system/development.nix)
    # - go, nodejs, python3 (in system/development.nix) 
    # - zip, unzip, p7zip, tree (in system/fileutils.nix)
    # - curl, wget (in system/networking.nix)
    # - sqlite (in system/utilities.nix)
    # Note: direnv is configured as a program above for shell integration
  ];

  # Environment variables for development
  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
    TERMINAL = "kitty";
    
    # Development paths
    CARGO_HOME = "$HOME/.cargo";
    GOPATH = "$HOME/go";
    
    # Node.js
    NPM_CONFIG_PREFIX = "$HOME/.npm-global";
    
    # Python
    PYTHONPATH = "$HOME/.local/lib/python3.11/site-packages";
  };

  # Shell aliases for development
  home.shellAliases = {
    # NixOS shortcuts
    nrs = "sudo nixos-rebuild switch --flake .";
    nrt = "sudo nixos-rebuild test --flake .";
    nrb = "sudo nixos-rebuild boot --flake .";
    hms = "home-manager switch --flake .";
    
    # System utilities
    ll = "ls -la";
    la = "ls -la";
    grep = "rg";
    find = "fd";
    cat = "bat";
    
    # Development
    v = "nvim";
    python = "python3";
    pip = "pip3";
  };
}
