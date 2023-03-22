-- Enable the following language servers
local mason = require('mason')
local mason_lsp = require('mason-lspconfig')

-- set them up (languages I use a lot have their own files.)
mason.setup()
mason_lsp.setup {
    ensure_installed = {
        "bashls",
        "golangci_lint_ls",
        "gopls",
        "jsonls",
        "lua_ls",
        "marksman",
        "pylsp",
        "rust_analyzer",
        "sourcery",
        "taplo",
        "yamlls",
        "zls",
    }
}
