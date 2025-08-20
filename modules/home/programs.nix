{ config, pkgs, ... }:

{
  # Program configurations
  programs = {
    # Neovim configuration
    neovim = {
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
  };
}
