-- Core Neovim Options - Professional IDE Setup

local M = {}

function M.setup()
  local opt = vim.opt
  
  -- Basic Editor Settings
  opt.number = true
  opt.relativenumber = true
  opt.cursorline = true
  opt.signcolumn = "yes:2"
  opt.colorcolumn = "120"
  
  -- Indentation
  opt.tabstop = 2
  opt.shiftwidth = 2
  opt.softtabstop = 2
  opt.expandtab = true
  opt.smartindent = true
  opt.autoindent = true
  
  -- Search
  opt.ignorecase = true
  opt.smartcase = true
  opt.hlsearch = true
  opt.incsearch = true
  
  -- Visual
  opt.termguicolors = true
  opt.wrap = false
  opt.scrolloff = 8
  opt.sidescrolloff = 8
  opt.showmode = false
  
  -- Behavior
  opt.hidden = true
  opt.backup = false
  opt.writebackup = false
  opt.swapfile = false
  opt.updatetime = 300
  opt.timeoutlen = 500
  
  -- Completion
  opt.completeopt = { "menu", "menuone", "noselect" }
  opt.pumheight = 15
  opt.pumblend = 10
  
  -- Splits
  opt.splitright = true
  opt.splitbelow = true
  
  -- Files
  opt.undofile = true
  opt.undolevels = 10000
  
  -- Mouse and clipboard
  opt.mouse = "a"
  opt.clipboard = "unnamedplus"
  
  -- Disable netrw for nvim-tree
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1
end

-- Auto-setup
M.setup()

return M
