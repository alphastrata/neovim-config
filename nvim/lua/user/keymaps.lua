-- NOTE: KEYBINDINGS, these will not be for you viewer, unless you use a colemak layout.
local opts = { noremap = true, silent = true }

-- helper func to reduce typing
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts) --NOTE: lifted from Chris'
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- PackerUpdate and Compile
keymap('n', '<leader>pu', ':PackerUpdate<CR>', opts)
keymap('n', '<leader>pc', ':PackerCompile<CR>', opts)

-- buffers
keymap('n', '<leader>Q', ':qall!<CR>', opts)
keymap('n', '<leader>w', ':w<CR>', opts)
keymap('n', '<leader>q', ':bd!<CR>', opts)
keymap('n', '<leader><TAB>', ":bnext<CR>", opts)
keymap('n', '<leader><S-TAB>', ":bprevious<CR>", opts)

keymap('n', '<leader>g', ':source ~/.config/nvim/init.lua<CR>', opts)

--terminal
keymap("n", "<leader>t", ':te zsh -l<CR>;t', opts)

-- sensible undo/redo
keymap('n', "U", '<C-r>', opts)

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts) -- push left
keymap("n", "<C-n>", "<C-w>n", opts) -- push up
keymap("n", "<C-e>", "<C-w>e", opts) -- push down
keymap("n", "<C-i>", "<C-w>i", opts) -- push up

-- Resize
keymap("n", "<C-n>", ":resize -2<CR>", opts)
keymap("n", "<C-e>", ":resize +2<CR>", opts)
keymap("n", "<C-h>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-i>", ":vertical resize +2<CR>", opts)

-- Indentation made good
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Useful telescopes...
keymap("n", "<leader>ct", ":Telescope colorscheme<CR>", opts)
keymap("n", "<leader>sp", ":Telescope spell_suggest<CR>", opts)
keymap("n", "<leader>f", ":Telescope find_files hidden=true no_ignore=true<CR>", opts)
keymap("n", "<leader>fd", ":Telescope fd<CR>", opts)
keymap("n", "<leader>fa", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>T", ":Telescope<CR>", opts)
keymap("n", "<leader>fb", ":Telescope file_browser<CR>", opts)

--NeoTree
keymap("n", "<leader>neo", ":Neotree<CR>", opts)
