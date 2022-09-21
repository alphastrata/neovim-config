-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	is_bootstrap = true
	vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
	vim.cmd [[packadd packer.nvim]]
end

-- INFO: PLUGINS:
require('packer').startup(function(use)
	use 'wbthomason/packer.nvim' -- package management
	use 'lewis6991/impatient.nvim' -- Load faster... apparently

	-- aesthetics:
	-- themes:
	use "ayu-theme/ayu-vim"
	use 'EdenEast/nightfox.nvim'
	use 'bluz71/vim-nightfly-guicolors'
	use 'folke/tokyonight.nvim'
	use 'lukas-reineke/indent-blankline.nvim' -- Add indentation guides even on blank lines
	use 'sh4hids/color-wheel.vim' -- Plugin to allow you to clone vscode themes into something neovim can handle
	use 'xiyaowong/nvim-transparent' -- I have a virtual background, that refreshes every 10 minutes and like to well, see that.

	-- use({ -- LSP_LINES is a plugin that pipes lsp-diagnostics into the neovim virtual text thingy -- I cannot make up my mind whether I hate, or love it...
	--   "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
	--   config = function()
	--     require("lsp_lines").setup()
	--   end,
	-- })

	-- tools:
	use 'lewis6991/spellsitter.nvim' -- spell better
	use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
	use 'numToStr/Comment.nvim' -- "cl" to comment/uncomment visual regions/lines
	use 'nvim-lua/plenary.nvim' -- all the lua functions you don't wanna write twice
	use 'nvim-lualine/lualine.nvim' -- statusline
	use 'nvim-treesitter/nvim-treesitter' -- Highlight, edit, and navigate code
	use 'nvim-treesitter/nvim-treesitter-textobjects' --  Additional textobjects for treesitter
	use 'p00f/nvim-ts-rainbow' -- Rainbow brackets, coz I use languages that use brackets.
	use 'tpope/vim-sleuth' -- Detect tabstop and shiftwidth automatically
	use 'williamboman/nvim-lsp-installer' -- Automatically install language servers to stdpath
	use { 'L3MON4D3/LuaSnip', requires = { 'saadparwaiz1/cmp_luasnip' } } -- Snippet Engine and Snippet Expansion
	use { 'folke/todo-comments.nvim', requires = 'nvim-lua/plenary.nvim' } -- Enables these TODO: comments to get that sweet, sweet highlighting.
	use { 'hrsh7th/nvim-cmp', requires = { 'hrsh7th/cmp-nvim-lsp' } } -- Autocompletion
	use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable "make" == 1 } -- Telescope is pretty famous by now, so no intros.
	use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } } -- Fuzzy Finder (files, lsp, etc)
	use { 'tzachar/cmp-tabnine', run = './install.sh', requires = 'hrsh7th/nvim-cmp' } -- Tabnine is like github autopilot (useful for working in unfamiliar languages)
	use { "windwp/nvim-autopairs", config = function() require("nvim-autopairs").setup {} end -- I don't like the autobracketing in neovim's default
	}

	-- Like everyone alive, I tried it -- decided it ain't worth it.
	-- Copilot NOTE: https://github.com/github/copilot.vim
	-- use("github/copilot.vim")

	-- INFO: GIT:
	use 'tpope/vim-fugitive' -- Git commands in nvim
	use 'tpope/vim-rhubarb' -- Fugitive-companion to interact with github
	use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } } -- Add git related info in the signs columns and popups

	-- Install all our plugins and packer, which manages them. (if not already installed)
	if is_bootstrap then
		require('packer').sync()
	end
end)

-- INFO: impatient allegedly improves startup time of lua-modules...
require('impatient')

require("transparent").setup({
	enable = true, -- boolean: enable transparent
	extra_groups = {
		"BufferLineTabClose",
		"BufferlineBufferSelected",
		"BufferLineFill",
		"BufferLineBackground",
		"BufferLineSeparator",
		"BufferLineIndicatorSelected",
	},
	exclude = {},
})

-- INFO: only if you've nuked the site/packer/pack dir lately...
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
	print '=================================='
	print '    Plugins are being installed'
	print '    Wait until Packer completes,'
	print '       then restart nvim'
	print '=================================='
	return
end

local tabnine = require('cmp_tabnine.config')
tabnine:setup({
	max_lines = 1000;
	max_num_results = 20;
	sort = true;
	run_on_every_keystroke = true;
	snippet_placeholder = '..';
	ignored_file_types = { -- default is not to ignore
		-- uncomment to ignore in lua:
		-- lua = true
	};
	show_prediction_strength = false;
})

vim.opt.list = true

-- Show indents (vertical lines)
require("indent_blankline").setup {
	show_current_context = true,
	show_current_context_start = true,
}

-- lualine
-- NOTE: you'll need ceratin nerdfonts installed for this to *not* look like shit
require('lualine').setup { --NOTE: basically the defaults.
	options = {
		icons_enabled = true,
		theme = 'auto',
		component_separators = { left = '', right = '' },
		section_separators = { left = '', right = '' },
		disabled_filetypes = {},
		always_divide_middle = true,
		globalstatus = true,
	},
	sections = {
		lualine_a = { 'mode' },
		lualine_b = { { 'FugitiveHead', icon = '' } },
		--lualine_b = { 'branch', 'diff', 'diagnostics' },
		lualine_c = { 'filename' },
		lualine_x = { 'encoding', 'filetype' },
		lualine_y = { 'progress' },
		lualine_z = { 'location' }
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { 'filename' },
		lualine_x = { 'location' },
		lualine_y = {},
		lualine_z = {}
	},
	tabline = {},
	extensions = {}
}

require('todo-comments').setup(
	{ -- NOTE: basically the defaults.
		signs = true, -- show icons in the signs column
		sign_priority = 8, -- sign priority
		-- keywords recognized as todo comments
		keywords = {
			FIX = {
				icon = " ", -- icon used for the sign, and in search results
				color = "error", -- can be a hex color, or a named color (see below)
				alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
				-- signs = false, -- configure signs for some keywords individually
			},
			TODO = { icon = " ", color = "info" },
			HACK = { icon = " ", color = "warning" },
			WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
			PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
			NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
		},
		merge_keywords = true, -- when true, custom keywords will be merged with the defaults
		-- highlighting of the line containing the todo comment
		-- * before: highlights before the keyword (typically comment characters)
		-- * keyword: highlights of the keyword
		-- * after: highlights after the keyword (todo text)
		highlight = {
			before = "empty", -- "fg" or "bg" or empty
			keyword = "bg", -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
			after = "fg", -- "fg" or "bg" or empty
			pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlightng (vim regex)
			comments_only = true, -- uses treesitter to match keywords in comments only
			max_line_len = 400, -- ignore lines longer than this
			exclude = {}, -- list of file types to exclude highlighting
		},
		-- list of named colors where we try to extract the guifg from the
		-- list of hilight groups or use the hex color if hl not found as a fallback
		colors = {
			error = { "LspDiagnosticsDefaultError", "ErrorMsg", "#DC2626" },
			warning = { "LspDiagnosticsDefaultWarning", "WarningMsg", "#FBBF24" },
			info = { "LspDiagnosticsDefaultInformation", "#2563EB" },
			hint = { "LspDiagnosticsDefaultHint", "#10B981" },
			default = { "Identifier", "#7C3AED" },
		},
		search = {
			command = "rg",
			args = {
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
			},
			-- regex that will be used to match keywords.
			-- don't replace the (KEYWORDS) placeholder
			pattern = [[\b(KEYWORDS):]], -- ripgrep regex
			-- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
		},
	}
)
-- Comment.nvim
require('Comment').setup(
	{ -- NOTE: basically the defaults.
		---Add a space b/w comment and the line
		---@type boolean|fun():boolean
		padding = true,

		---Whether the cursor should stay at its position
		---NOTE: This only affects NORMAL mode mappings and doesn't work with dot-repeat
		---@type boolean
		sticky = true,

		---Lines to be ignored while comment/uncomment.
		---Could be a regex string or a function that returns a regex string.
		---Example: Use '^$' to ignore empty lines
		---@type string|fun():string
		ignore = nil,

		---LHS of toggle mappings in NORMAL + VISUAL mode
		---@type table
		--NOTE: these are my only changes from the defaults...
		toggler = {
			---Line-comment toggle keymap
			line = 'cl', --comment line(s)
			---Block-comment toggle keymap
			block = 'gl',
		},

		---LHS of operator-pending mappings in NORMAL + VISUAL mode
		---@type table
		opleader = {
			---Line-comment keymap
			line = 'cl',
			---Block-comment keymap
			block = 'gl',
		},

		---LHS of extra mappings
		---@type table
		extra = {
			---Add comment on the line above
			above = 'gcO',
			---Add comment on the line below
			below = 'gco',
			---Add comment at the end of line
			eol = 'gcA',
		},

		---Create basic (operator-pending) and extended mappings for NORMAL + VISUAL mode
		---NOTE: If `mappings = false` then the plugin won't create any mappings
		---@type boolean|table
		mappings = {
			---Operator-pending mapping
			---Includes `gcc`, `gbc`, `gc[count]{motion}` and `gb[count]{motion}`
			---NOTE: These mappings can be changed individually by `opleader` and `toggler` config
			basic = true,
			---Extra mapping
			---Includes `gco`, `gcO`, `gcA`
			extra = true,
			---Extended mapping
			---Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
			extended = false,
		},

		---Pre-hook, called before commenting the line
		---@type fun(ctx: CommentCtx):string
		pre_hook = nil,

		---Post-hook, called after commenting is done
		---@type fun(ctx: CommentCtx)
		post_hook = nil,
	})

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf-native')

-- LSP settings (and most of my LSP related mappings)
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
	-- NOTE: lifted from TJ's kickstarter.
	local nmap = function(keys, func, desc)
		if desc then
			desc = 'LSP: ' .. desc
		end

		vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
	end
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
end

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
	ensure_installed = { 'c', 'rust', 'python', 'go', 'lua' }, -- add your languages here.
	highlight = { enable = true, color = 'cyan', additional_vim_regex_highlighting = true },
	indent = { enable = true },
	auto_install = true,
	sync_install = false,
	rainbow = {
		enabled = true,
		extended_mode = true,
		max_file_lines = nil,
		colors = {
			"#cc241d",
			"#a89984",
			"#b16286",
			"#d79921",
			"#689d6a",
			"#d65d0e",
			"#458588",
		},
		termcolors = {
			"Red",
			"Green",
			"Yellow",
			"Blue",
			"Magenta",
			"Cyan",
			"White",
		},

	}
}

-- nvim-cmp supports additional completion capabilities
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Enable the following language servers
local servers = { 'clangd', 'rust_analyzer', 'sumneko_lua', 'gopls', 'jsonls', 'cmake', 'dockerls',
	'pyright', 'grammarly' }

require 'lspconfig'.wgsl_analyzer.setup {
	cmd = { "wgsl_analyzer" },
	filetypes = { "wgsl" },
	settings = {},
}

-- Ensure the servers above are installed
require('nvim-lsp-installer').setup {
	ensure_installed = servers,
}

for _, lsp in ipairs(servers) do
	require('lspconfig')[lsp].setup {
		on_attach = on_attach,
		capabilities = capabilities,
	}
end

-- NOTE: Also lifted from TJ's kickstarter
-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ';')

table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

local lspconfig = require("lspconfig")

lspconfig.sumneko_lua.setup {
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = {
				version = 'LuaJIT',
				path = runtime_path,
			},
			diagnostics = {
				globals = { 'vim' },
			},
			workspace = { library = vim.api.nvim_get_runtime_file('', true) },
		},
	},
}

-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'

cmp.setup {
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert {
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<CR>'] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		},
		['<Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { 'i', 's' }),
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { 'i', 's' }),
	},
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'cmp_tabnine' },
		{ name = 'luasnip' },
	},
}
-- LSP_LINES, as mentioned above can put lsp_diagnostics etc INLINE with your code..
-- require("lsp_lines").setup(
--   vim.diagnostic.config({
--     virtual_text = false,
--   })
-- )
-- FORMATTING --
-- require("null-ls").setup({
--   sources = {
--     require("null-ls").builtins.formatting.stylua,
--     require("null-ls").builtins.formateltting.black,
--     require("null-ls").builtins.formatting.rustfmt,
--     require("null-ls").builtins.formatting.gofmt,
--     require("null-ls").builtins.formatting.uncrustify,
--     require("null-ls").builtins.completion.spell,
--     require("null-ls").builtins.diagnostics.cppcheck,
--   },
-- })
-- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
-- require("null-ls").setup({
--   -- you can reuse a shared lspconfig on_attach callback here
--   on_attach = function(client, bufnr)
--     if client.supports_method("textDocument/formatting") then
--       vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
--       vim.api.nvim_create_autocmd("BufWritePre", {
--         group = augroup,
--         buffer = bufnr,
--         callback = function()
--           -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
--           vim.lsp.buf.formatting_sync()
--         end,
--       })
--     end
--   end,
-- })
--
-- Gitsigns, just shows you + for additions and - for removals etc kinda like a quick n dirty git-diff
require('gitsigns').setup {
	signs = {
		add = { text = '+' },
		change = { text = '~' },
		delete = { text = '_' },
		topdelete = { text = '‾' },
		changedelete = { text = '~' },
	},
}


-- NOTE: KEYBINDINGS, these will not be for you viewer, unless you use a colemak layout.
M = {}
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
keymap('n', '<leader>w', ':w!<CR>', opts)
keymap('n', '<leader>q', ':bd!<CR>', opts)
keymap('n', '<leader><TAB>', ":bnext<CR>", opts)
keymap('n', '<leader><S-TAB>', ":bprevious<CR>", opts)

keymap('n', '<leader>g', ':source ~/.config/nvim/init.lua<CR>', opts)

--terminal
keymap("n", "<leader>t", ':te fish -l<CR>;t', opts)

-- colemak bindings hnei for hjklitTlNEI
keymap("n", "h", "h", opts)
keymap("n", "n", "j", opts)
keymap("n", "e", "k", opts)
keymap("n", "i", "l", opts)
keymap("n", "t", "i", opts)
keymap("n", "T", "I", opts)
keymap("n", "l", "o", opts)
keymap("n", "N", "B", opts)
keymap("n", "E", "}", opts)
keymap("n", "I", "{", opts)

-- because lua doesn't respect my noremaps>< TODO: do better...
keymap("v", "h", "h", opts)
keymap("v", "n", "j", opts)
keymap("v", "e", "k", opts)
keymap("v", "i", "l", opts)
keymap("v", "t", "i", opts)
keymap("v", "T", "I", opts)
keymap("v", "l", "o", opts)
keymap("v", "N", "B", opts)
keymap("v", "E", "}", opts)
keymap("v", "I", "{", opts)
-- because lua doesn't respect >< TODO: do better...
keymap("x", "h", "h", opts)
keymap("x", "n", "j", opts)
keymap("x", "e", "k", opts)
keymap("x", "i", "l", opts)
keymap("x", "t", "i", opts)
keymap("x", "T", "I", opts)
keymap("x", "l", "o", opts)
keymap("x", "N", "B", opts)
keymap("x", "E", "}", opts)
keymap("x", "I", "{", opts)

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

-- Visual Block --
-- Move text up and down, just be in visual mode and use SHIFT N or E
keymap("x", "N", ":move '>+1<CR>gv-gv", opts)
keymap("x", "E", ":move '<-2<CR>gv-gv", opts)

keymap("n", "<leader>ct", ":Telescope colorscheme<CR>", opts)
keymap("n", "<leader>spell", ":Telescope spell_suggest<CR>", opts)
keymap("n", "<leader>f", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>fa", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>T", ":Telescope<CR>", opts)

-- INFO: what was settings.vim
-- See `:help vim.o`
vim.o.breakindent = true
vim.o.completeopt = 'menuone,noselect'
vim.o.hlsearch = false
vim.o.ignorecase = true
vim.o.mouse = 'a'
vim.o.scrolloff = 35 --min lines at bottom of screen from cursor
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
vim.cmd [[colorscheme terafox]]
--vim.cmd [[colorscheme ayu]]
--vim.cmd [[colorscheme horizon]]
--vim.g.ayucolor = "mirage"

-- Autofmt on save
vim.cmd [[au BufWritePre * lua vim.lsp.buf.formatting()]]

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
