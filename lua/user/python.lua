local lspconfig = require('lspconfig')

-- -- Pylsp options
lspconfig.pylsp.setup {
    cmd = { 'pylsp' },
    on_attach = function(client)
        -- Set up additional keybindings
        vim.api.nvim_buf_set_keymap(0, 'n', '<leader>pd', '<cmd>lua vim.lsp.buf.definition()<CR>',
            { noremap = true, silent = true })
    end,
    capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
    settings = {
        pylsp = {
            plugins = {
                ruff =
                {
                    enabled = true,
                    lineLength = 180,
                },
                mcabe =
                {
                    enabled = false,
                },
                pycodestyle =
                {
                    enabled = false,
                },
                pyflakes =
                {
                    enabled = false,
                },
                pylint =
                {
                    enabled = false,
                },
            },
        },
    },
}

-- Ruff-lsp is allegedly the GOAT
lspconfig.ruff_lsp.setup {
    capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),


}
-- pylint = {
--     enabled = true,
--     executable = 'ruff',
-- },
-- autopep8 = {
--     enabled = false,
-- },
-- yapf = {
--     enabled = false,
-- }
