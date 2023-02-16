-- Install packer -> => !=  -> => ~= !=
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    is_bootstrap = true
    vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
    vim.cmd [[packadd packer.nvim]]
end

-- Imports
require('packer').startup(function(use)
    use 'wbthomason/packer.nvim' -- package management
    use 'lewis6991/impatient.nvim' -- Load faster... apparently

    -- aesthetics:
    use({
        'mechatroner/rainbow_csv',
        'arzg/vim-colors-xcode',
        'EdenEast/nightfox.nvim',
        'fenetikm/falcon',
        'bluz71/vim-nightfly-guicolors',
        'folke/tokyonight.nvim',
        'rcarriga/nvim-notify',
        { 'catppuccin/nvim',
            as = 'catppuccin', },
        {
            'bluz71/vim-moonfly-colors', as = 'moonfly'
        },
        'folke/lsp-colors.nvim',
        'savq/melange-nvim',
        'lukas-reineke/indent-blankline.nvim', -- Add indentation guides even on blank lines
        'xiyaowong/nvim-transparent', -- I have a virtual background, that refreshes every 10 minutes and like to well, see that.
        'folke/noice.nvim',
        requires = {
            'MunifTanjim/nui.nvim',
            'rcarriga/nvim-notify',
        }
    })

    -- tools:
    use 'ggandor/leap.nvim'
    use 'lewis6991/spellsitter.nvim' -- spell better
    use 'MTDL9/vim-log-highlighting'
    use 'numToStr/Comment.nvim' -- 'cl' to comment/uncomment visual regions/lines
    use 'nvim-lua/plenary.nvim' -- all the lua functions you don't wanna write twice
    use 'nvim-lualine/lualine.nvim' -- statusline
    use 'nvim-treesitter/nvim-treesitter-context' -- Get the name of the block you're in redardless of how offscreen that line may be...
    use 'nvim-treesitter/nvim-treesitter' -- Highlight, edit, and navigate code
    use 'simrat39/rust-tools.nvim'
    use 'tpope/vim-sleuth' -- Detect tabstop and shiftwidth automatically
    use { 'folke/todo-comments.nvim', requires = 'nvim-lua/plenary.nvim' } -- Enables these TODO: comments to get that sweet, sweet highlighting.
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
    use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } } -- Fuzzy Finder (files, lsp, etc)
    use { 'nvim-telescope/telescope-file-browser.nvim' }
    --auto complete
    use {
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-vsnip',
        'hrsh7th/nvim-cmp',
        'hrsh7th/vim-vsnip',
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
    }
    use { "windwp/nvim-autopairs", config = function() require("nvim-autopairs").setup {} end } -- I don't like the autobracketing in neovim's default
    -- LSP
    use {
        'williamboman/nvim-lsp-installer', -- Automatically install language servers to stdpath
        'neovim/nvim-lspconfig',
        'williamboman/mason-lspconfig.nvim',
        'williamboman/mason.nvim',
    }
    -- NEOTREE
    use {
        'nvim-neo-tree/neo-tree.nvim',
        branch = 'v2.x',
        requires = {
            'nvim-lua/plenary.nvim',
            'kyazdani42/nvim-web-devicons',
            'MunifTanjim/nui.nvim',
        }
    }
    -- GO
    use {
        'fatih/vim-go', -- vim tooling
    }

    -- Like everyone alive, I tried it -- decided it ain't worth it.
    -- Copilot NOTE: https://github.com/github/copilot.vim
    -- use('github/copilot.vim')
    -- use 'Exafunction/codeium.vim'

    -- INFO: GIT:
    use({ 'tpope/vim-fugitive', -- Git commands in nvim
        'tpope/vim-rhubarb', -- Fugitive-companion to interact with github
        { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
    }) -- Add git related info in the signs columns and popups

    -- Install all our plugins and packer, which manages them. (if not already installed)
    if is_bootstrap then
        require('packer').sync()
    end
end)

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
