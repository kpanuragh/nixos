{ pkgs, ... }:

{
  # System packages organized by category
  environment.systemPackages = with pkgs; [
    # Essential GUI apps
    kitty
    firefox
    wofi
    
    # System utilities
    libarchive
    sshpass
    
    # Development core
    vscode
    git
    gcc
    gnumake
    nodejs
    python3Full
    
    # Development languages
    rustup
    go
    julia
    php83
    php83Packages.composer
    
    # Development tools
    gh
    volta
    mise
    direnv
    
    # Hyprland/Wayland specific
    fuzzel
    hyprpaper
    hypridle
    hyprlock
    pyprland
    grimblast
    wf-recorder
    swww
    cliphist
    dunst
    brightnessctl
    pavucontrol
    
    # Media and entertainment
    mpvpaper
    ffmpeg
    cava
    spotify-player
    imagemagick
    
    # System monitoring and debugging
    btop
    iotop
    iftop
    sysstat
    lm_sensors
    strace
    ltrace
    lsof
    procs
    
    # Networking tools
    mtr
    iperf3
    dnsutils
    aria2
    socat
    nmap
    ipcalc
    ethtool
    
    # File management
    nnn
    eza
    tree
    fd
    fzf
    ripgrep
    bat
    delta
    zip
    unzip
    p7zip
    xz
    zstd
  ];
}
