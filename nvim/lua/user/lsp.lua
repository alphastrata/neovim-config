-- LSP settings (and most of my LSP related mappings)
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
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
    nmap("ga", vim.lsp.buf.code_action, 'code actions')
end


-- nvim-cmp supports additional completion capabilities
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Enable the following language servers
local servers = { 'rust_analyzer', 'marksman', 'lua_ls', 'gopls', 'jsonls', 'grammarly' }

-- Ensure the servers above are installed
require('nvim-lsp-installer').setup {
    ensure_installed = servers,
}

require("mason").setup()

-- Attach em to buffers...
for _, lsp in ipairs(servers) do
    require('lspconfig')[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
    }
end
