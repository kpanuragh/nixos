-- Fresh Professional IDE Configuration
-- All essential IDE features without format-on-save

-- Set leader key first
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Load core configuration
require('config.options')
require('config.keymaps')
require('config.autocmds')

-- Load plugins
require('plugins.init')
