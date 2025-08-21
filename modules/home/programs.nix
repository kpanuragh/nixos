{ config, pkgs, ... }:

{
  # Program configurations
  programs = {

    # Neovim - Fully configured IDE
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      
      plugins = with pkgs.vimPlugins; [
        # Essential plugins loaded directly by Nix
        plenary-nvim  # Required for many plugins
        
        # Core UI and navigation
        nvim-tree-lua
        telescope-nvim
        telescope-fzf-native-nvim
        which-key-nvim
        lualine-nvim
        bufferline-nvim
        nvim-web-devicons
        alpha-nvim
        
        # LSP and completion
        nvim-lspconfig
        nvim-cmp
        cmp-nvim-lsp
        cmp-buffer
        cmp-path
        cmp-cmdline
        luasnip
        cmp_luasnip
        friendly-snippets
        
        # GitHub Copilot
        copilot-vim
        copilot-cmp
        
        # Treesitter for syntax highlighting
        nvim-treesitter.withAllGrammars
        nvim-treesitter-textobjects
        
        # Git integration
        gitsigns-nvim
        fugitive
        
        # Utility plugins
        nvim-autopairs
        comment-nvim
        indent-blankline-nvim
        toggleterm-nvim
        trouble-nvim
        
        # Colorschemes
        tokyonight-nvim
        catppuccin-nvim
        onedark-nvim
        
        # Additional utilities
        nui-nvim      # UI component library
      ];
      
      extraLuaConfig = ''
        -- Basic settings
        vim.opt.number = true
        vim.opt.relativenumber = true
        vim.opt.tabstop = 2
        vim.opt.shiftwidth = 2
        vim.opt.expandtab = true
        vim.opt.smartindent = true
        vim.opt.wrap = false
        vim.opt.ignorecase = true
        vim.opt.smartcase = true
        vim.opt.hlsearch = false
        vim.opt.incsearch = true
        vim.opt.termguicolors = true
        vim.opt.scrolloff = 8
        vim.opt.signcolumn = "yes"
        vim.opt.updatetime = 50
        vim.opt.colorcolumn = "120"
        vim.opt.mouse = "a"
        vim.opt.clipboard = "unnamedplus"
        
        -- Leader key
        vim.g.mapleader = " "
        vim.g.maplocalleader = " "
        
        -- Colorscheme
        require('tokyonight').setup({
          style = "night",
          transparent = false,
        })
        vim.cmd[[colorscheme tokyonight]]
        
        -- Treesitter configuration
        require('nvim-treesitter.configs').setup {
          -- Don't try to ensure_installed since we're using Nix
          auto_install = false,
          highlight = { enable = true },
          indent = { enable = true },
          incremental_selection = {
            enable = true,
            keymaps = {
              init_selection = "gnn",
              node_incremental = "grn",
              scope_incremental = "grc",
              node_decremental = "grm",
            },
          },
        }
        
        -- Prevent treesitter from trying to install parsers
        require('nvim-treesitter.install').compilers = {}
        
        -- LSP Configuration
        local lspconfig = require('lspconfig')
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        
        -- PHP
        lspconfig.phpactor.setup({
          capabilities = capabilities,
          init_options = {
            ["language_server_phpstan.enabled"] = true,
            ["language_server_psalm.enabled"] = true,
          }
        })
        
        -- HTML, CSS, JSON
        lspconfig.html.setup({ capabilities = capabilities })
        lspconfig.cssls.setup({ capabilities = capabilities })
        lspconfig.jsonls.setup({ capabilities = capabilities })
        
        -- JavaScript/TypeScript
        lspconfig.ts_ls.setup({ capabilities = capabilities })
        
        -- Tailwind CSS
        lspconfig.tailwindcss.setup({ capabilities = capabilities })
        
        -- Emmet
        lspconfig.emmet_ls.setup({
          capabilities = capabilities,
          filetypes = { "html", "css", "javascript", "typescript", "php" }
        })
        
        -- LSP keybindings (no formatting)
        vim.api.nvim_create_autocmd('LspAttach', {
          group = vim.api.nvim_create_augroup('UserLspConfig', {}),
          callback = function(ev)
            local opts = { buffer = ev.buf }
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
            vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
            vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          end,
        })
        
        -- Completion setup
        local cmp = require('cmp')
        local luasnip = require('luasnip')
        
        cmp.setup({
          snippet = {
            expand = function(args)
              luasnip.lsp_expand(args.body)
            end,
          },
          mapping = cmp.mapping.preset.insert({
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
            ['<Tab>'] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
              else
                fallback()
              end
            end, { 'i', 's' }),
            ['<S-Tab>'] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
              else
                fallback()
              end
            end, { 'i', 's' }),
          }),
          sources = cmp.config.sources({
            { name = 'copilot' },
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
          }, {
            { name = 'buffer' },
            { name = 'path' },
          })
        })
        
        -- Load friendly snippets
        require("luasnip.loaders.from_vscode").lazy_load()
        
        -- GitHub Copilot setup
        vim.g.copilot_no_tab_map = true
        vim.g.copilot_assume_mapped = true
        vim.g.copilot_tab_fallback = ""
        
        -- Telescope setup
        require('telescope').setup{
          defaults = {
            file_ignore_patterns = {"node_modules", ".git", "vendor"},
            mappings = {
              i = {
                ["<C-u>"] = false,
                ["<C-d>"] = false,
              },
            },
          }
        }
        require('telescope').load_extension('fzf')
        
        -- Telescope keybindings
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live grep' })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find buffers' })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Help tags' })
        vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = 'Recent files' })
        vim.keymap.set('n', '<leader>fc', builtin.commands, { desc = 'Commands' })
        vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Keymaps' })
        
        -- Nvim-tree setup
        require('nvim-tree').setup({
          view = {
            width = 30,
          },
          filters = {
            dotfiles = false,
          },
        })
        vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { silent = true })
        
        -- Lualine setup
        require('lualine').setup {
          options = {
            theme = 'tokyonight'
          }
        }
        
        -- Bufferline setup
        require('bufferline').setup {}
        
        -- Gitsigns setup
        require('gitsigns').setup()
        
        -- Autopairs setup
        require('nvim-autopairs').setup({
          check_ts = true,
        })
        
        -- Comment setup
        require('Comment').setup()
        
        -- Which-key setup
        require('which-key').setup({
          triggers = {
            { "<leader>", mode = { "n", "v" } },
          }
        })
        
        -- Register which-key mappings
        require('which-key').add({
          { "<leader>f", group = "Find" },
          { "<leader>x", group = "Diagnostics" },
          { "<leader>b", group = "Buffer" },
          { "<leader>c", group = "Code" },
          { "<leader>g", group = "Git" },
        })
        
        -- Alpha (dashboard) setup
        require('alpha').setup(require('alpha.themes.startify').config)
        
        -- Trouble setup
        require('trouble').setup()
        vim.keymap.set('n', '<leader>xx', '<cmd>TroubleToggle<cr>')
        vim.keymap.set('n', '<leader>xw', '<cmd>TroubleToggle workspace_diagnostics<cr>')
        vim.keymap.set('n', '<leader>xd', '<cmd>TroubleToggle document_diagnostics<cr>')
        
        -- ToggleTerm setup
        require('toggleterm').setup{
          direction = 'horizontal',
          size = 20,
        }
        vim.keymap.set('n', '<leader>t', ':ToggleTerm<CR>')
        
        -- Additional keybindings
        vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = 'Save file' })
        vim.keymap.set('n', '<leader>q', ':q<CR>', { desc = 'Quit' })
        vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>', { desc = 'Clear search' })
        vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move to left window' })
        vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move to bottom window' })
        vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move to top window' })
        vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move to right window' })
        
        -- Buffer navigation
        vim.keymap.set('n', '<Tab>', ':bnext<CR>', { desc = 'Next buffer' })
        vim.keymap.set('n', '<S-Tab>', ':bprev<CR>', { desc = 'Previous buffer' })
        vim.keymap.set('n', '<leader>bd', ':bdelete<CR>', { desc = 'Delete buffer' })
        
        -- Better escape
        vim.keymap.set('i', 'jk', '<ESC>', { desc = 'Escape insert mode' })
        vim.keymap.set('i', 'kj', '<ESC>', { desc = 'Escape insert mode' })
        
        -- Move text up and down
        vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move text down' })
        vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move text up' })
        
        -- Keep cursor centered
        vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next search result' })
        vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Previous search result' })
        
        -- Better indenting
        vim.keymap.set('v', '<', '<gv', { desc = 'Indent left' })
        vim.keymap.set('v', '>', '>gv', { desc = 'Indent right' })
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
}
