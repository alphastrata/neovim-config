-- NOTE: KEYBINDINGS, these will not be for you viewer, unless you use a colemak layout.
local opts = { noremap = true, silent = true }

-- helper func to reduce typing
local keymap = vim.api.nvim_set_keymap
--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts) --NOTE: lifted from Chris'
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- helper to do normal mode remapping:
local nmap = function(keys, func, desc)
    if desc then
        desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
end

-- PackerUpdate and Compile
nmap('<leader>pu', ':PackerUpdate<CR>', 'PackerUpdate')
nmap('<leader>pc', ':PackerCompile<CR>', 'PackerCompile')

-- buffers
nmap('<leader>Q', ':qall!<CR>', 'Quit all buffers')
nmap('<leader>w', ':w<CR>', 'Write current buffer')
nmap('<leader>q', ':bd!<CR>', 'Close current buffer')
nmap('<leader><TAB>', ":bnext<CR>", 'Next buffer')
nmap('<leader><S-TAB>', ":bprevious<CR>", 'Previous buffer')

nmap('<leader>g', ':source ~/.config/nvim/init.lua<CR>', 'Source init file')

-- sensible undo/redo
nmap("U", '<C-r>', 'Redo')

-- Normal --
-- Better window navigation
nmap("<C-h>", "<C-w>h", 'Push window left')
nmap("<C-n>", "<C-w>n", 'Push window up')
nmap("<C-e>", "<C-w>e", 'Push window down')
nmap("<C-i>", "<C-w>i", 'Push window right')

-- Resize
nmap("<C-n>", ":resize -2<CR>", 'Resize up')
nmap("<C-e>", ":resize +2<CR>", 'Resize down')
nmap("<C-h>", ":vertical resize -2<CR>", 'Resize left')
nmap("<C-i>", ":vertical resize +2<CR>", 'Resize right')

-- Indentation made good
nmap("v", "<", "<gv", 'Indent left')
nmap("v", ">", ">gv", 'Indent right')

-- Useful telescopes...
nmap("<leader>ct", ":Telescope colorscheme<CR>", 'Telescope colorscheme')
nmap("<leader>sp", ":Telescope spell_suggest<CR>", 'Telescope spell suggest')
nmap("<leader>f", ":Telescope find_files hidden=true no_ignore=true<CR>", 'Telescope find files')
nmap("<leader>fd", ":Telescope fd<CR>", 'Telescope fd')
nmap("<leader>fa", ":Telescope live_grep<CR>", 'Telescope live grep')
nmap("<leader>T", ":Telescope<CR>", 'Telescope')

-- NeoTree
nmap("<leader>neo", ":Neotree<CR>", 'Open NeoTree')

-- Keymaps best applied on attach to a buffer...
-- WARN: A lot, if not all of my hotkeys will only make sense to users of colemak layouts.
nmap('<leader>h', vim.diagnostic.goto_prev) -- space+h to jump to previous error/warning as thrown by lsp
nmap('<leader>i', vim.diagnostic.goto_next) -- space+i for the opposite
nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
nmap('K', vim.lsp.buf.hover) -- NOTE: probably the most useful hotkey I have.
nmap('dec', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
nmap('def', vim.lsp.buf.definition, '[G]oto [D]efinition') -- NOTE: the 2nd most useful
nmap('imp', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
nmap('ref', require('telescope.builtin').lsp_references)
nmap('sig', vim.lsp.buf.signature_help, 'Signature Documentation')
nmap('type', vim.lsp.buf.type_definition, 'Type Definition')
nmap("ga", vim.lsp.buf.code_action, 'code actions')
