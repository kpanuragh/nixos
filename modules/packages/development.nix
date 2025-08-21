{ config, lib, pkgs, ... }:

{
  # Development packages
  environment.systemPackages = with pkgs; [
    # Core development tools
    git
    gcc
    gnumake
    cmake
    pkg-config
    
    # Language runtimes and compilers
    nodejs
    python3Full
    rustup
    go
    julia
    php83
    php83Packages.composer
    
    # Language servers for Neovim
    nodePackages.typescript-language-server
    nodePackages.vscode-langservers-extracted  # HTML, CSS, JSON, ESLint
    nodePackages."@vue/language-server"
    nodePackages.svelte-language-server
    nodePackages.typescript
    phpactor
    tailwindcss-language-server
    emmet-ls
    
    # Development utilities
    gh              # GitHub CLI
    volta           # Node version manager
    mise            # Tool version manager
    direnv          # Environment loader
    docker-compose  # Container orchestration
    
    # Editors and IDEs
    vscode
    
    # Database tools
    mysql-workbench
    
    # API testing
    insomnia
    
    # Hardware development
    arduino-ide
  ];
}
