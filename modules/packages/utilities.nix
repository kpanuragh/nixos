{ config, lib, pkgs, ... }:

{
  # Specialized tools and utilities
  environment.systemPackages = with pkgs; [
    # Radio and SDR
    gqrx            # SDR software
    dump1090-fa    # ADS-B decoder
    
    # AI and automation
    shell-gpt       # GPT in terminal
    
    # Power management
    power-profiles-daemon
    
    # System libraries and dependencies
    glib
    gtk3
    gvfs
    gtksourceview3
    libgtop
    bluez
    networkmanager
    wireplumber
    
    # Database
    mariadb
    sqlite
    
    # Cloud tools
    awscli2
    
    # Android development tools
    apktool
    dex2jar
    jadx
    quark
    zulu8           # Java 8
    
    # Documentation and help
    tldr            # Simplified man pages
    translate-shell # Translation tool
    
    # Productivity
    hugo            # Static site generator
    glow            # Markdown viewer
    wakatime-cli    # Time tracking
    
    # Miscellaneous
    cowsay
    gnupg
    nix-output-monitor
    dart-sass       # Sass compiler
    killall
    tree-sitter     # Parser generator
  ];
}
