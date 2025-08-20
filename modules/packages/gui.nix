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
    slack
    telegram-desktop
    
    # Security
    bitwarden-cli
    bitwarden-desktop
    
    # AI-Powered Productivity
    obsidian            # Knowledge management with AI plugins
    logseq              # Local-first knowledge graph
    
    # Writing and Documentation
    ghostwriter         # Distraction-free writing
    
    # Office and Productivity
    libreoffice-fresh   # Office suite with AI features
    
    # Note-taking and PKM
    joplin-desktop      # Note-taking with sync
    
    # AI Chat and Research
    zotero              # Research management
    anki                # Spaced repetition learning
    
    # AI Image Tools
    upscayl             # AI image upscaler
    
    # Utilities
    rpi-imager          # Raspberry Pi imager
    nwg-look            # GTK theme switcher
    
    # Entertainment
    hakuneko            # Manga downloader
  ];
}
