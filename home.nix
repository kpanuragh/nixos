{ config, pkgs,inputs, ... }:

{
  # TODO please change the username & home directory to your own
  home.username = "anuragh";
  home.homeDirectory = "/home/anuragh";

  home.packages = with pkgs; [
    # Custom packages
    inputs.ollama-tui.packages.${system}.default
    
    # Core utilities (frequently used)
    wget
    curl
    tree
    fd
    fzf
    ripgrep
    bat
    eza
    
    # Development essentials
    python3Full
    python312Packages.requests
    python312Packages.pynvim
    nodejs
    nodemon
    rustup
    go
    julia
    
    # System monitoring
    neofetch
    btop
    iotop
    iftop
    sysstat
    lm_sensors
    
    # Media & Graphics
    ffmpeg
    imagemagick
    cava
    mpvpaper
    
    # Hyprland specific
    hyprpaper
    hypridle
    hyprlock
    grimblast
    swappy
    pyprland
    brightnessctl
    pavucontrol
    cliphist
    swww
    
    # Networking tools
    mtr
    iperf3
    dnsutils
    aria2
    nmap
    
    # File management
    nnn
    zip
    unzip
    p7zip
    xz
    zstd
    
    # Development tools
    gh
    volta
    glow
    wakatime-cli
    mise
    direnv
    translate-shell
    tldr
    sqlite
    
    # Archives and compression
    gnutar
    
    # Text processing
    jq
    yq-go
    gnused
    gawk
    delta
    
    # System tools
    strace
    ltrace
    lsof
    procs
    killall
    
    # Wayland clipboard
    wl-clipboard
    
    # Theming
    nordzy-cursor-theme
    adwaita-icon-theme
    arc-theme
    papirus-icon-theme
    
    # Audio
    playerctl
    pulseaudio
    
    # Notifications
    dunst
    libnotify
    
    # GUI Applications (only essential ones in home-manager)
    mysql-workbench
    insomnia
    arduino-ide
    
    # Specialized tools
    gqrx
    dump1090-fa
    shell-gpt
    power-profiles-daemon
    wf-recorder
    hyprsunset
    matugen
    mariadb
    rpi-imager
    hdparm
    
    # Development languages and tools
    php83
    php83Packages.composer
    gcc
    gnumake
    hugo
    gopls
    dart-sass
    
    # Android development
    apktool
    dex2jar
    jadx
    quark
    zulu8
    
    # Cloud tools
    awscli2
    
    # Terminal improvements
    warp-terminal
    fuzzel
    nwg-look
    
    # System libraries
    glib
    gtk3
    gvfs
    gtksourceview3
    libgtop
    bluez
    networkmanager
    hyprpolkitagent
    wireplumber
    
    # Miscellaneous
    cowsay
    gnupg
    mmv-go
    nix-output-monitor
    file
    which
    trashy
    pciutils
    usbutils
    hakuneko
    spotify-player
    
    # Fonts and themes
    comixcursors
    gnome-themes-extra
  ];
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;
    withPython3 = true;
    
    plugins = with pkgs.vimPlugins; [
      # Core functionality
      nvim-treesitter.withAllGrammars
      telescope-nvim
      
      # Completion
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline
      cmp_luasnip
      luasnip
      friendly-snippets
      lspkind-nvim
      
      # AI assistance
      avante-nvim
      copilot-lua
      copilot-cmp
      
      # UI improvements
      bufferline-nvim
      tokyonight-nvim
      
      # Utilities
      comment-nvim
    ];
    
    extraConfig = ''
      lua << EOF
      -- Basic settings
      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.expandtab = true
      vim.opt.shiftwidth = 2
      vim.opt.tabstop = 2
      vim.opt.smartindent = true
      vim.opt.wrap = false
      vim.opt.swapfile = false
      vim.opt.backup = false
      vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
      vim.opt.undofile = true
      vim.opt.hlsearch = false
      vim.opt.incsearch = true
      vim.opt.termguicolors = true
      vim.opt.scrolloff = 8
      vim.opt.signcolumn = "yes"
      vim.opt.isfname:append("@-@")
      vim.opt.updatetime = 50
      
      -- Set colorscheme
      vim.cmd[[colorscheme tokyonight]]
      EOF
    '';
  };
#programs.nixvim.enable = true;
  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "Anuragh K P";
    userEmail = "anuragh.kp@cubettech.com";
    lfs.enable = true;
  };
programs.tmux = {
    enable = true;
    shortcut = "a";
    # aggressiveResize = true; -- Disabled to be iTerm-friendly
    baseIndex = 1;
    newSession = true;
    # Stop tmux+escape craziness.
    escapeTime = 0;
    # Force tmux to use /tmp for sockets (WSL2 compat)
    secureSocket = false;

    plugins = with pkgs; [
      tmuxPlugins.better-mouse-mode
    ];

    extraConfig = ''
      # https://old.reddit.com/r/tmux/comments/mesrci/tmux_2_doesnt_seem_to_use_256_colors/
      set -g default-terminal "xterm-256color"
      set -ga terminal-overrides ",*256col*:Tc"
      set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
      set-environment -g COLORTERM "truecolor"

      # Mouse works as expected
      set-option -g mouse on
      # easy-to-remember split pane commands
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"
    '';
  };

  # starship - an customizable prompt for any shell
  programs.starship = {
    enable = true;
    # custom settings
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };

  # alacritty - a cross-platform, GPU-accelerated terminal emulator
  programs.alacritty = {
    enable = true;
      };
  programs.waybar = {
  enable = true;
};


    # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";
}
