-- Enable the following language servers
require("mason-lspconfig").setup {
    ensure_installed = {
        "bashls",
        "dockerls",
        "elixirls",
        "gopls",
        "jsonls",
        "lua_ls",
        "marksman",
        "pylsp",
        "rust_analyzer",
        "sourcery",
        "taplo",
        "yamlls",
    },
}
-- Manage all the servers with mason
require("mason").setup()
