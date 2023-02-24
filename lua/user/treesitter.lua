-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
    ensure_installed = { 'c', 'rust', 'python', 'go', 'lua', 'markdown', 'haskell', 'json', 'latex', 'toml' }, -- add your languages here.
    highlight = { enable = true, additional_vim_regex_highlighting = true },
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
