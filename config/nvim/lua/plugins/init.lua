-- Plugin Configuration Manager

local M = {}

function M.setup()
  -- Load all plugin configurations
  require('plugins.colorscheme')
  require('plugins.treesitter')
  require('plugins.lsp')
  require('plugins.completion')
  require('plugins.telescope')
  require('plugins.nvim-tree')
  require('plugins.ui')
  require('plugins.git')
  require('plugins.editing')
end

-- Auto-setup
M.setup()

return M
