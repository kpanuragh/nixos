-- Telescope Configuration - Fuzzy Finder

local M = {}

function M.setup()
  local telescope = require('telescope')
  local actions = require('telescope.actions')
  
  telescope.setup({
    defaults = {
      prompt_prefix = "   ",
      selection_caret = " ",
      entry_prefix = "  ",
      sorting_strategy = "ascending",
      layout_strategy = "horizontal",
      layout_config = {
        horizontal = {
          prompt_position = "top",
          preview_width = 0.55,
        },
        width = 0.87,
        height = 0.80,
        preview_cutoff = 120,
      },
      file_ignore_patterns = {
        "node_modules",
        ".git/",
        "vendor/",
        "%.lock",
        "__pycache__/",
        "%.pyc",
        "%.class",
        "%.pdf",
        "%.mkv",
        "%.mp4",
        "%.zip",
      },
      mappings = {
        i = {
          ["<C-n>"] = actions.move_selection_next,
          ["<C-p>"] = actions.move_selection_previous,
          ["<C-c>"] = actions.close,
          ["<Down>"] = actions.move_selection_next,
          ["<Up>"] = actions.move_selection_previous,
          ["<CR>"] = actions.select_default,
          ["<C-x>"] = actions.select_horizontal,
          ["<C-v>"] = actions.select_vertical,
          ["<C-t>"] = actions.select_tab,
          ["<C-u>"] = actions.preview_scrolling_up,
          ["<C-d>"] = actions.preview_scrolling_down,
          ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
          ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
          ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        },
        n = {
          ["<esc>"] = actions.close,
          ["<CR>"] = actions.select_default,
          ["<C-x>"] = actions.select_horizontal,
          ["<C-v>"] = actions.select_vertical,
          ["<C-t>"] = actions.select_tab,
          ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
          ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
          ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
          ["j"] = actions.move_selection_next,
          ["k"] = actions.move_selection_previous,
          ["H"] = actions.move_to_top,
          ["M"] = actions.move_to_middle,
          ["L"] = actions.move_to_bottom,
          ["gg"] = actions.move_to_top,
          ["G"] = actions.move_to_bottom,
          ["<C-u>"] = actions.preview_scrolling_up,
          ["<C-d>"] = actions.preview_scrolling_down,
          ["?"] = actions.which_key,
        },
      },
    },
    
    pickers = {
      find_files = {
        theme = "dropdown",
        find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
      },
      live_grep = {
        theme = "ivy",
      },
      buffers = {
        theme = "dropdown",
        previewer = false,
        sort_lastused = true,
      },
      git_files = {
        theme = "dropdown",
      },
      help_tags = {
        theme = "ivy",
      },
    },
    
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
    },
  })
  
  -- Load extensions
  telescope.load_extension('fzf')
  
  -- Keymaps
  local builtin = require('telescope.builtin')
  
  -- File pickers
  vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
  vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live grep' })
  vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find buffers' })
  vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = 'Recent files' })
  vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Help tags' })
  vim.keymap.set('n', '<leader>fc', builtin.commands, { desc = 'Commands' })
  vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Keymaps' })
  vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = 'Find word' })
  
  -- Git pickers
  vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = 'Git files' })
  vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = 'Git commits' })
  vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = 'Git branches' })
  vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = 'Git status' })
  
  -- LSP pickers
  vim.keymap.set('n', '<leader>lr', builtin.lsp_references, { desc = 'LSP references' })
  vim.keymap.set('n', '<leader>ld', builtin.lsp_definitions, { desc = 'LSP definitions' })
  vim.keymap.set('n', '<leader>li', builtin.lsp_implementations, { desc = 'LSP implementations' })
  vim.keymap.set('n', '<leader>ls', builtin.lsp_document_symbols, { desc = 'Document symbols' })
  vim.keymap.set('n', '<leader>lw', builtin.lsp_workspace_symbols, { desc = 'Workspace symbols' })
  vim.keymap.set('n', '<leader>le', builtin.diagnostics, { desc = 'Diagnostics' })
  
  -- Resume
  vim.keymap.set('n', '<leader>f.', builtin.resume, { desc = 'Resume last picker' })
end

-- Auto-setup
M.setup()

return M
