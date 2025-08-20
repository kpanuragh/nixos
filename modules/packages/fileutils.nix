{ config, lib, pkgs, ... }:

{
  # File management and utilities
  environment.systemPackages = with pkgs; [
    # File managers
    nnn             # Terminal file manager
    
    # File listing and search
    eza             # Modern ls
    tree            # Directory tree
    fd              # Modern find
    fzf             # Fuzzy finder
    ripgrep         # Fast grep
    
    # File viewers and editors
    bat             # Modern cat
    delta           # Git diff viewer
    
    # Archive tools
    zip
    unzip
    p7zip
    xz
    zstd
    gnutar
    libarchive
    
    # File utilities
    file            # File type detection
    which           # Command locator
    trashy          # Safe rm
    mmv-go          # Bulk rename
    
    # Text processing
    jq              # JSON processor
    yq-go           # YAML processor
    gnused          # GNU sed
    gawk            # GNU awk
  ];
}
