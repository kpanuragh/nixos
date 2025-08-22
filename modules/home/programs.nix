{ config, pkgs, ... }:

{
  # Link Neovim configuration
  home.file = {
    ".config/nvim" = {
      source = ./../../config/nvim;
      recursive = true;
    };
  };

  # Program configurations
  programs = {

    # Neovim - Fresh Professional IDE
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      
      plugins = with pkgs.vimPlugins; [
        # Essential dependencies
        plenary-nvim
        nui-nvim
        nvim-web-devicons
        
        # Core UI and navigation
        nvim-tree-lua
        telescope-nvim
        telescope-fzf-native-nvim
        which-key-nvim
        lualine-nvim
        bufferline-nvim
        alpha-nvim
        indent-blankline-nvim
        
        # LSP and diagnostics
        nvim-lspconfig
        trouble-nvim
        
        # Enhanced completion system
        nvim-cmp
        cmp-nvim-lsp
        cmp-buffer
        cmp-path
        cmp-cmdline
        cmp-calc
        cmp-emoji
        cmp-nvim-lua
        luasnip
        cmp_luasnip
        friendly-snippets
        
        # GitHub Copilot integration
        copilot-vim
        copilot-cmp
        copilot-lua
        
        # Treesitter for syntax highlighting
        nvim-treesitter.withAllGrammars
        nvim-treesitter-textobjects
        
        # Git integration
        gitsigns-nvim
        fugitive
        
        # Editing enhancements
        nvim-autopairs
        comment-nvim
        nvim-surround
        toggleterm-nvim
        
        # Colorschemes
        tokyonight-nvim
        catppuccin-nvim
        onedark-nvim
      ];
    };

    # Terminal multiplexer
    tmux = {
      enable = true;
      shortcut = "a";
      baseIndex = 1;
      newSession = true;
      escapeTime = 0;
      secureSocket = false;

      plugins = with pkgs; [
        tmuxPlugins.better-mouse-mode
      ];

      extraConfig = ''
        # 256 color support
        set -g default-terminal "xterm-256color"
        set -ga terminal-overrides ",*256col*:Tc"
        set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
        set-environment -g COLORTERM "truecolor"

        # Mouse support
        set-option -g mouse on
        
        # Easy split pane commands
        bind | split-window -h -c "#{pane_current_path}"
        bind - split-window -v -c "#{pane_current_path}"
        bind c new-window -c "#{pane_current_path}"
      '';
    };

    # Terminal emulator
    alacritty.enable = true;
    
    # VS Code with AI extensions
    vscode = {
      enable = true;
      profiles = {
        default = {
          extensions = with pkgs.vscode-extensions; [
            # AI-powered coding assistance
            github.copilot
            github.copilot-chat
            
            # Language support with AI features
            ms-python.python
            ms-vscode.cpptools
            rust-lang.rust-analyzer
            bradlc.vscode-tailwindcss
            
            # Writing and documentation AI
            streetsidesoftware.code-spell-checker
            davidanson.vscode-markdownlint
            
            # Productivity and UI
            vscodevim.vim
            ms-vscode.theme-tomorrowkit
            pkief.material-icon-theme
            
            # Git integration
            eamodio.gitlens
            
            # Remote development
            ms-vscode-remote.remote-ssh
            ms-vscode-remote.remote-containers
          ];
          
          userSettings = {
            "github.copilot.enable" = {
              "*" = true;
              "yaml" = true;
              "plaintext" = true;
              "markdown" = true;
            };
            "editor.inlineSuggest.enabled" = true;
            "editor.suggestSelection" = "first";
            "editor.tabCompletion" = "on";
            "editor.wordBasedSuggestions" = "matchingDocuments";
            "files.autoSave" = "afterDelay";
            "files.autoSaveDelay" = 1000;
            "workbench.colorTheme" = "Tomorrow Night Blue";
            "workbench.iconTheme" = "material-icon-theme";
          };
        };
      };
    };
  };

  # GTK configuration for crisp system fonts
  gtk = {
    enable = true;
    
    font = {
      name = "Inter";
      size = 11;
    };
    
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    
    gtk3.extraConfig = {
      gtk-font-name = "Inter 11";
      gtk-application-prefer-dark-theme = true;
      gtk-button-images = false;
      gtk-menu-images = false;
      gtk-enable-event-sounds = false;
      gtk-enable-input-feedback-sounds = false;
      gtk-xft-antialias = true;
      gtk-xft-hinting = true;
      gtk-xft-hintstyle = "hintslight";
      gtk-xft-rgba = "rgb";
    };
    
    gtk4.extraConfig = {
      gtk-font-name = "Inter 11";
      gtk-application-prefer-dark-theme = true;
      gtk-enable-event-sounds = false;
      gtk-enable-input-feedback-sounds = false;
    };
  };
  
  # Qt configuration to match GTK
  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };
}
