-- Nvim-tree Configuration - File Explorer

local M = {}

function M.setup()
  require('nvim-tree').setup({
    sort_by = "case_sensitive",
    view = {
      adaptive_size = true,
      width = 30,
      side = "left",
    },
    renderer = {
      group_empty = true,
      icons = {
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = true,
        },
        glyphs = {
          default = "",
          symlink = "",
          git = {
            unstaged = "✗",
            staged = "✓",
            unmerged = "",
            renamed = "➜",
            untracked = "★",
            deleted = "",
            ignored = "◌",
          },
        },
      },
      special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
    },
    filters = {
      dotfiles = false,
      custom = { ".git", "node_modules", ".cache" },
    },
    git = {
      enable = true,
      ignore = false,
      timeout = 400,
    },
    actions = {
      use_system_clipboard = true,
      change_dir = {
        enable = true,
        global = false,
        restrict_above_cwd = false,
      },
      open_file = {
        quit_on_open = false,
        resize_window = true,
        window_picker = {
          enable = true,
          chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
          exclude = {
            filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
            buftype = { "nofile", "terminal", "help" },
          },
        },
      },
    },
    live_filter = {
      prefix = "[FILTER]: ",
      always_show_folders = true,
    },
    tab = {
      sync = {
        open = false,
        close = false,
        ignore = {},
      },
    },
    notify = {
      threshold = vim.log.levels.INFO,
    },
    ui = {
      confirm = {
        remove = true,
        trash = true,
      },
    },
  })
  
  -- Keymaps
  vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = 'Toggle file explorer' })
  vim.keymap.set('n', '<leader>o', ':NvimTreeFocus<CR>', { desc = 'Focus file explorer' })
end

-- Auto-setup
M.setup()

return M
