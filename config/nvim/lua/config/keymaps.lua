-- Professional IDE Keymaps

local M = {}

local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end

function M.setup()
  -- General keymaps
  map("n", "<leader>w", ":w<CR>", { desc = "Save file" })
  map("n", "<leader>q", ":q<CR>", { desc = "Quit" })
  map("n", "<C-s>", ":w<CR>", { desc = "Save file" })
  map("i", "<C-s>", "<Esc>:w<CR>", { desc = "Save file" })
  
  -- Clear search highlighting
  map("n", "<Esc>", ":nohlsearch<CR>", { desc = "Clear search highlight" })
  
  -- Better escape
  map("i", "jk", "<Esc>", { desc = "Exit insert mode" })
  map("i", "kj", "<Esc>", { desc = "Exit insert mode" })
  
  -- Window navigation
  map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
  map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
  map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
  map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })
  
  -- Buffer navigation
  map("n", "<Tab>", ":bnext<CR>", { desc = "Next buffer" })
  map("n", "<S-Tab>", ":bprev<CR>", { desc = "Previous buffer" })
  map("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer" })
  
  -- Text manipulation
  map("v", "J", ":move '>+1<CR>gv=gv", { desc = "Move text down" })
  map("v", "K", ":move '<-2<CR>gv=gv", { desc = "Move text up" })
  map("v", "<", "<gv", { desc = "Outdent line" })
  map("v", ">", ">gv", { desc = "Indent line" })
  
  -- Selection formatting (manual formatting on selection)
  map("v", "<leader>f", "=", { desc = "Format selected text" })
  
  -- File operations
  map("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
  
  -- Terminal
  map("n", "<leader>t", ":ToggleTerm<CR>", { desc = "Toggle terminal" })
  map("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
end

-- Auto-setup
M.setup()

return M
