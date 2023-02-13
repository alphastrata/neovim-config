-- Install packer -> => !=  -> => ~= !=
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
    use({
        'arzg/vim-colors-xcode',
        'EdenEast/nightfox.nvim',
        'fenetikm/falcon',
        'bluz71/vim-nightfly-guicolors',
        'folke/tokyonight.nvim',
        { "catppuccin/nvim",
            as = "catppuccin", },
        {
            'bluz71/vim-moonfly-colors', as = 'moonfly'
        },
        'folke/lsp-colors.nvim',
        'savq/melange-nvim'
    })


    use 'lukas-reineke/indent-blankline.nvim' -- Add indentation guides even on blank lines
    use 'xiyaowong/nvim-transparent' -- I have a virtual background, that refreshes every 10 minutes and like to well, see that.

    -- NOICE:
    use({
        "folke/noice.nvim",
        requires = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        }
    })

    -- tools:
    use 'lewis6991/spellsitter.nvim' -- spell better
    use 'mechatroner/rainbow_csv'
    use 'neovim/nvim-lspconfig'
    use 'MTDL9/vim-log-highlighting'
    use 'simrat39/rust-tools.nvim'
    use 'numToStr/Comment.nvim' -- "cl" to comment/uncomment visual regions/lines
    use 'nvim-lua/plenary.nvim' -- all the lua functions you don't wanna write twice
    use 'nvim-lualine/lualine.nvim' -- statusline
    use 'nvim-treesitter/nvim-treesitter' -- Highlight, edit, and navigate code
    use 'nvim-treesitter/nvim-treesitter-context' -- Get the name of the block you're in redardless of how offscreen that line may be...
    use 'tpope/vim-sleuth' -- Detect tabstop and shiftwidth automatically
    use 'williamboman/nvim-lsp-installer' -- Automatically install language servers to stdpath
    use { 'L3MON4D3/LuaSnip', requires = { 'saadparwaiz1/cmp_luasnip' } } -- Snippet Engine and Snippet Expansion
    use { 'folke/todo-comments.nvim', requires = 'nvim-lua/plenary.nvim' } -- Enables these TODO: comments to get that sweet, sweet highlighting.
    use { 'hrsh7th/nvim-cmp', requires = { 'hrsh7th/cmp-nvim-lsp' } } -- Autocompletion
    use 'ggandor/leap.nvim'
    use { 'nvim-telescope/telescope-fzf-native.nvim',
        run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
    use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } } -- Fuzzy Finder (files, lsp, etc)
    use { "nvim-telescope/telescope-file-browser.nvim" }
    use { "windwp/nvim-autopairs", config = function() require("nvim-autopairs").setup {} end -- I don't like the autobracketing in neovim's default
    }
    use { "williamboman/mason.nvim" } -- automatically manage my lsp servers for me pls!

    -- NEOTREE
    use {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "kyazdani42/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        }
    }
    use 'fatih/vim-go' -- vim tooling

    -- Like everyone alive, I tried it -- decided it ain't worth it.
    -- Copilot NOTE: https://github.com/github/copilot.vim
    -- use("github/copilot.vim")
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
