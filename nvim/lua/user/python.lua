local lspconfig = require('lspconfig')

-- Pylsp options
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
                pylint = {
                    enabled = true,
                    executable = 'pylint',
                    args = { '--rcfile=pylintrc' },
                },
                autopep8 = {
                    enabled = true,
                    executable = 'autopep8',
                    args = { '--ignore=E266' },
                },
            },
        },
    },
}

-- Ruff-lsp is allegedly the GOAT
lspconfig.ruff_lsp.setup {
    capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),

}
