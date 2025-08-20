{ config, lib, pkgs, ... }:

{
  # Essential GUI applications
  environment.systemPackages = with pkgs; [
    # Browsers
    firefox
    
    # Terminal emulators
    kitty
    warp-terminal
    
    # Communication
    discord
    slack-desktop
    telegram-desktop
    
    # Security
    bitwarden-cli
    bitwarden-desktop
    
    # AI-Powered Productivity
    obsidian            # Knowledge management with AI plugins
    logseq              # Local-first knowledge graph
    
    # Writing and Documentation
    typora              # Beautiful markdown editor
    ghostwriter         # Distraction-free writing
    
    # AI Development Tools
    # cursor              # AI-powered code editor (may not be in nixpkgs)
    
    # Office and Productivity
    libreoffice-fresh   # Office suite with AI features
    
    # Design and Creativity
    # figma-linux         # Design tool (may not be in nixpkgs)
    
    # Note-taking and PKM
    joplin-desktop      # Note-taking with sync
    trilium-desktop     # Hierarchical note taking
    
    # AI Chat and Research
    zotero              # Research management
    anki                # Spaced repetition learning
    
    # AI Image Tools
    upscayl             # AI image upscaler
    
    # Email with AI features
    mailspring          # Modern email client
    
    # Utilities
    rpi-imager          # Raspberry Pi imager
    nwg-look            # GTK theme switcher
    
    # Entertainment
    hakuneko            # Manga downloader
  ];
}
