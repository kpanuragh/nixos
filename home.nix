{ config, pkgs,inputs, ... }:

{
  # TODO please change the username & home directory to your own
  home.username = "anuragh";
  home.homeDirectory = "/home/anuragh";
  
  home.packages = with pkgs; [
  inputs.astal.packages.${system}.default
  inputs.hyprpanel.packages.${pkgs.system}.wrapper
  # System Information & Resource Monitoring
  neofetch
  btop
  iotop
  iftop
  sysstat
  lm_sensors
  pciutils
  usbutils
  insomnia
  ffmpeg
  lzip
  cava
  grimblast
  power-profiles-daemon
  wf-recorder
  hyprsunset
  matugen
  killall
  # File Management & Navigation
  nnn
  eza
  tree
  fd
  ripgrep
  file
  which
  trashy

  # Archives
  xz
  p7zip
  zstd
  gnutar

  # Text & Data Processing
  jq
  yq-go
  gnused
  gawk
  delta # A viewer for git and diff output
  bat   # A cat(1) clone with syntax highlighting and Git integration

  # Networking
  mtr
  iperf3
  dnsutils
  ldns
  aria2
  socat
  nmap
  ipcalc
  ethtool

  # Development & Productivity
  gcc
  gnumake
  hugo
  volta
  glow
  wakatime-cli
  mise
  direnv
  gh # GitHub CLI
  translate-shell
  tldr # a collection of community-maintained help pages for command-line tools
  sqlite

  # System Call & Library Monitoring
  strace
  ltrace
  lsof

  # Wayland/Hyprland specific
  hyprpaper
  dunst
  libnotify
  hypridle
  hyprlock
  grim # screenshot tool
  slurp # for selecting a region for grim
  swappy # for editing screenshots
  pyprland
  brightnessctl
  walker
  pavucontrol
  swww
  spotify-player
  # Theming & Appearance
  nordzy-cursor-theme
  adwaita-icon-theme
  arc-theme
  comixcursors
  gnome-themes-extra
  papirus-icon-theme

  # Nix specific
  nix-output-monitor

  # Miscellaneous Utilities
  cowsay
  gnupg
  procs # A modern replacement for ps
  mmv-go # rename multiple files using your editor
  gopls
  hyprpolkitagent
  wireplumber
  libgtop
  bluez
  networkmanager
  dart-sass
  upower
  gvfs
  gtksourceview3
];
   programs.neovim = {
   enable = true;
     viAlias = true;
     vimAlias = true;
     plugins = with pkgs; [
     vimPlugins.nvim-treesitter.withAllGrammars
     vimPlugins.avante-nvim
     vimPlugins.bufferline-nvim
     vimPlugins.nvim-cmp
     vimPlugins.cmp-nvim-lsp
     vimPlugins.cmp-buffer
     vimPlugins.cmp-path
     vimPlugins.cmp-cmdline
     vimPlugins.cmp_luasnip
     vimPlugins.luasnip
     vimPlugins.friendly-snippets
     vimPlugins.lspkind-nvim
     vimPlugins.copilot-cmp
     vimPlugins.tokyonight-nvim
     vimPlugins.comment-nvim
     vimPlugins.copilot-lua
     vimPlugins.telescope-nvim

     ];
 };
#programs.nixvim.enable = true;
  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "Anuragh";
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
    # custom settings
    settings = {
      opacity = 0.5;
      env.TERM = "xterm-256color";
       font = {
      normal = {
        family = "FiraCode Nerd Font";
        style = "Regular";
      };
      size = 12;
    };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };
  programs.waybar = {
  enable = true;

  settings = {
    mainBar = {
      layer = "top";
      position = "bottom";
      height = 30;
      margin-top = 5;
      margin-bottom = 5;
      margin-left = 5;
      margin-right = 5;

      "modules-left" = [ "hyprland/workspaces" "hyprland/window" ];
      "modules-center" = [ "clock" ];
      "modules-right" = [ "tray" "memory" "cpu" "pulseaudio" "network" "battery" ];

      "hyprland/workspaces" = {
        format = "{icon}";
        "on-click" = "activate";
        "format-icons" = {
          "1" = "󰎦"; "2" = "󰎩"; "3" = "󰎬";
          "4" = "󰎮"; "5" = "󰎰";
          urgent = "󱨇";
          default = "󰎣";
        };
      };

      "hyprland/window" = {
        format = "Window: {}";
        "max-length" = 35;
      };

      tray = {
        "icon-size" = 18;
        spacing = 8;
      };

      clock = {
        format = " {:%I:%M %p}";
        "format-alt" = " {:%A, %B %d, %Y}";
        "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      };

      cpu = {
        format = "CPU {usage}%";
        tooltip = true;
        "on-click" = "alacritty -e btop";
      };

      memory = {
        format = "󰍛 {used:0.1f}G/{total:0.1f}G";
        "on-click" = "alacritty -e btop";
      };

      battery = {
        states = { warning = 30; critical = 15; };
        format = "{icon} {capacity}%";
        "format-charging" = "󰂄 {capacity}%";
        "format-plugged" = "󰂄 {capacity}%";
        "format-alt" = "{icon} {time}";
        "format-icons" = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
      };

      network = {
        "format-wifi" = "󰖩 {essid}";
        "format-ethernet" = "󰈀 Connected";
        "format-disconnected" = "󰖪 Disconnected";
        "tooltip-format" = "{ifname} via {gwaddr} ";
        "on-click" = "alacritty -e nmtui";
      };

      pulseaudio = {
        format = "{icon} {volume}%";
        "format-muted" = "󰖁 Muted";
        "on-click" = "pavucontrol";
        "format-icons" = {
          headphone = "󰋋"; "hands-free" = "󰋋";
          headset = "󰋋"; phone = "󰏲";
          portable = "󰏲"; car = "󰄋";
          default = [ "" "" "" ];
        };
      };
    };
  };

  style = ''
    /* Dark Elegant Theme */
    * {
        font-family: "JetBrainsMono Nerd Font", FontAwesome, sans-serif;
        font-size: 12px;
        font-weight: bold;
        border: none;
        border-radius: 0;
    }

    window#waybar {
        background: #1e1e2e;
        color: #e0e0e0;
        border-radius: 12px;
        min-height: 0;
    }

    tooltip {
        background: #181825;
        color: #f5f5f5;
        border: 2px solid #89b4fa;
        border-radius: 8px;
    }

    #workspaces, #clock, #battery, #pulseaudio, #network, #cpu, #memory, #tray {
        padding: 0 8px;
        margin: 0 3px;
        background: #282a36;
        border-radius: 6px;
    }

    #workspaces button {
        padding: 2px 5px;
        margin: 2px 2px;
        background: transparent;
        color: #cdd6f4;
        border-radius: 6px;
        transition: background 0.3s ease, color 0.3s ease;
    }

    #workspaces button.active {
        background: #89b4fa;
        color: #1e1e2e;
    }

    #workspaces button:hover {
        background: #6272a4;
        color: #ffffff;
    }

    #clock {
        background: #44475a;
        color: #f1fa8c;
    }

    #battery {
        color: #a6e3a1;
    }
    #battery.charging, #battery.plugged {
        color: #89dceb;
    }

    #pulseaudio {
        color: #94e2d5;
    }
    #pulseaudio.muted {
        color: #f38ba8;
    }

    #network {
        color: #fab387;
    }
    #network.disconnected {
        color: #f38ba8;
    }

    #cpu {
        color: #f38ba8;
    }

    #memory {
        color: #cba6f7;
    }

    #tray {
        padding-right: 10px;
        margin-right: 6px;
        background: #313244;
    }
  '';
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
