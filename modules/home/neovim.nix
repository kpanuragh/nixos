{ config, pkgs, ... }:

{
  # Comprehensive Neovim IDE configuration
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
      telescope-fzf-native-nvim
      plenary-nvim
      
      # File explorer
      nvim-tree-lua
      nvim-web-devicons
      
      # LSP and completion
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline
      cmp_luasnip
      luasnip
      friendly-snippets
      lspkind-nvim
      
      # Formatting and linting
      null-ls-nvim
      mason-nvim
      mason-lspconfig-nvim
      
      # AI assistance
      copilot-lua
      copilot-cmp
      
      # Git integration
      gitsigns-nvim
      vim-fugitive
      
      # UI improvements
      bufferline-nvim
      lualine-nvim
      tokyonight-nvim
      alpha-nvim
      indent-blankline-nvim
      
      # Language specific
      vim-php-namespace
      vim-blade
      emmet-vim
      typescript-vim
      vim-javascript
      vim-vue
      
      # Utilities
      comment-nvim
      autopairs-nvim
      which-key-nvim
      toggleterm-nvim
      trouble-nvim
      
      # Debugging
      nvim-dap
      nvim-dap-ui
      nvim-dap-virtual-text
    ];
    
    extraLuaConfig = ''
      -- Basic settings
      vim.g.mapleader = " "
      vim.g.maplocalleader = " "
      
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
      vim.opt.timeoutlen = 300
      vim.opt.completeopt = "menu,menuone,noselect"
      vim.opt.pumheight = 10
      
      -- Set colorscheme
      vim.cmd[[colorscheme tokyonight-storm]]
      
      -- Key mappings
      local keymap = vim.keymap.set
      local opts = { noremap = true, silent = true }
      
      -- File explorer
      keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
      
      -- Telescope
      keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts)
      keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", opts)
      keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", opts)
      keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", opts)
      
      -- Buffer navigation
      keymap("n", "<Tab>", ":BufferLineCycleNext<CR>", opts)
      keymap("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", opts)
      keymap("n", "<leader>x", ":bdelete<CR>", opts)
      
      -- Window navigation
      keymap("n", "<C-h>", "<C-w>h", opts)
      keymap("n", "<C-j>", "<C-w>j", opts)
      keymap("n", "<C-k>", "<C-w>k", opts)
      keymap("n", "<C-l>", "<C-w>l", opts)
      
      -- Terminal
      keymap("n", "<leader>t", ":ToggleTerm<CR>", opts)
      
      -- Plugin configurations
      require("nvim-tree").setup({
        sort_by = "case_sensitive",
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = false,
        },
      })
      
      require("bufferline").setup({
        options = {
          numbers = "none",
          close_command = "bdelete! %d",
          right_mouse_command = "bdelete! %d",
          left_mouse_command = "buffer %d",
          middle_mouse_command = nil,
          separator_style = "slant",
          always_show_bufferline = false,
        }
      })
      
      require("lualine").setup({
        options = {
          theme = "tokyonight",
          component_separators = { left = "", right = ""},
          section_separators = { left = "", right = ""},
        },
        sections = {
          lualine_a = {"mode"},
          lualine_b = {"branch", "diff", "diagnostics"},
          lualine_c = {"filename"},
          lualine_x = {"encoding", "fileformat", "filetype"},
          lualine_y = {"progress"},
          lualine_z = {"location"}
        },
      })
      
      -- Treesitter configuration
      require("nvim-treesitter.configs").setup({
        ensure_installed = { 
          "lua", "vim", "vimdoc", "query", "php", "html", "css", "javascript", 
          "typescript", "vue", "svelte", "json", "yaml", "toml", "markdown",
          "bash", "python", "go", "rust"
        },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true
        },
      })
      
      -- LSP configuration
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      
      -- PHP LSP
      lspconfig.phpactor.setup({
        capabilities = capabilities,
      })
      
      -- HTML LSP
      lspconfig.html.setup({
        capabilities = capabilities,
      })
      
      -- CSS LSP
      lspconfig.cssls.setup({
        capabilities = capabilities,
      })
      
      -- JavaScript/TypeScript LSP
      lspconfig.ts_ls.setup({
        capabilities = capabilities,
      })
      
      -- Vue LSP
      lspconfig.volar.setup({
        capabilities = capabilities,
        filetypes = {"vue"},
      })
      
      -- Tailwind CSS LSP
      lspconfig.tailwindcss.setup({
        capabilities = capabilities,
      })
      
      -- Emmet LSP
      lspconfig.emmet_ls.setup({
        capabilities = capabilities,
        filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
      })
      
      -- JSON LSP
      lspconfig.jsonls.setup({
        capabilities = capabilities,
      })
      
      -- LSP key mappings
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local opts = { buffer = ev.buf }
          keymap("n", "gD", vim.lsp.buf.declaration, opts)
          keymap("n", "gd", vim.lsp.buf.definition, opts)
          keymap("n", "K", vim.lsp.buf.hover, opts)
          keymap("n", "gi", vim.lsp.buf.implementation, opts)
          keymap("n", "<C-k>", vim.lsp.buf.signature_help, opts)
          keymap("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
          keymap("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
          keymap("n", "<leader>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, opts)
          keymap("n", "<leader>D", vim.lsp.buf.type_definition, opts)
          keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)
          keymap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
          keymap("n", "gr", vim.lsp.buf.references, opts)
          keymap("n", "<leader>f", function()
            vim.lsp.buf.format { async = true }
          end, opts)
        end,
      })
      
      -- Autocompletion setup
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")
      
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
          ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
          ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
          ["<C-y>"] = cmp.config.disable,
          ["<C-e>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
          }),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expandable() then
              luasnip.expand()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol",
            maxwidth = 50,
            ellipsis_char = "...",
          }),
        },
        sources = {
          { name = "copilot" },
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        },
      })
      
      -- GitHub Copilot setup
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
      
      require("copilot_cmp").setup()
      
      -- Git signs
      require("gitsigns").setup({
        signs = {
          add = { text = "+" },
          change = { text = "~" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
        },
      })
      
      -- Comments
      require("Comment").setup()
      
      -- Autopairs
      require("nvim-autopairs").setup({
        check_ts = true,
        ts_config = {
          lua = { "string", "source" },
          javascript = { "string", "template_string" },
          java = false,
        },
        disable_filetype = { "TelescopePrompt", "spectre_panel" },
        fast_wrap = {
          map = "<M-e>",
          chars = { "{", "[", "(", '"', "'" },
          pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
          offset = 0,
          end_key = "$",
          keys = "qwertyuiopzxcvbnmasdfghjkl",
          check_comma = true,
          highlight = "PmenuSel",
          highlight_grey = "LineNr",
        },
      })
      
      -- Which-key
      require("which-key").setup({
        plugins = {
          marks = true,
          registers = true,
          spelling = {
            enabled = true,
            suggestions = 20,
          },
        },
      })
      
      -- Terminal
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        direction = "float",
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          border = "curved",
          winblend = 0,
          highlights = {
            border = "Normal",
            background = "Normal",
          },
        },
      })
      
      -- Trouble (diagnostics)
      require("trouble").setup({
        icons = false,
        fold_open = "v",
        fold_closed = ">",
        indent_lines = false,
        signs = {
          error = "error",
          warning = "warn",
          hint = "hint",
          information = "info"
        },
        use_diagnostic_signs = false
      })
      
      -- Indent blankline
      require("ibl").setup({
        indent = {
          char = "┊",
        },
        scope = {
          enabled = false,
        },
      })
      
      -- Alpha (start screen)
      require("alpha").setup(require("alpha.themes.startify").config)
      
      -- Auto commands for specific file types
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "php" },
        callback = function()
          vim.opt_local.shiftwidth = 4
          vim.opt_local.tabstop = 4
        end,
      })
      
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "html", "css", "javascript", "typescript", "vue", "svelte" },
        callback = function()
          vim.opt_local.shiftwidth = 2
          vim.opt_local.tabstop = 2
        end,
      })
      
      -- Emmet configuration
      vim.g.user_emmet_install_global = 0
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "html", "css", "javascript", "typescript", "vue", "svelte" },
        callback = function()
          vim.cmd("EmmetInstall")
        end,
      })
      
      -- PHP specific settings
      vim.g.php_html_load = 1
      vim.g.php_html_in_heredoc = 1
      vim.g.php_html_in_nowdoc = 1
      vim.g.php_sql_query = 1
      vim.g.php_sql_heredoc = 1
      vim.g.php_sql_nowdoc = 1
    '';
  };
}
