vim.g.termguicolors = true
local M = {}

-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

vim.opt.list = true
vim.o.breakindent = true
vim.o.completeopt = 'menuone,noselect'
vim.o.hlsearch = false
vim.o.ignorecase = true
vim.o.mouse = 'a'
vim.o.scrolloff = 15 --min lines at bottom of screen from cursor
vim.o.showtabline = 0 -- never use tabs, fzf or telescope will take you to open tabs if they're there.
vim.o.smartcase = true
vim.o.termguicolors = true
vim.o.undofile = true
vim.o.updatetime = 250
vim.wo.number = true -- numbers on lhs
vim.wo.relativenumber = true -- numbers relative
vim.wo.signcolumn = 'yes'


vim.cmd [[set clipboard+=unnamedplus]] -- yank/from to os clipboard

-- Themes, I have many and change often depending on the time of day etc.
vim.cmd [[colorscheme tokyonight-storm]]

-- Autofmt on save
vim.cmd [[au BufWritePre * lua vim.lsp.buf.format()]]

-- NEOTREE
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

-- These are specific to Neovide
vim.cmd [[
if exists("g:neovide")
	let g:neovide_refresh_rate=60
	let g:neovide_transparency=0.8
	let g:neovide_cursor_antialiasing=v:true
	let g:neovide_scroll_animation_length = 0.4
	let g:neovide_cursor_animation_length=0.05
endif
]]
