local cmp = require 'cmp'
local luasnip = require 'luasnip'

cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert {
            ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
            ['<C-n>'] = cmp.mapping.scroll_docs(-4),
            ['<C-e>'] = cmp.mapping.scroll_docs(4),
            ['<Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                else
                    fallback()
                end
            end,
            { 'i', 's' }),
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
        { name = 'nvim__lsp_document_symbol' },
        { name = 'nvim__lsp_signature_help' },
        { name = 'luasnip' },
        { name = 'path' },
        { name = "buffer",                   keyword_length = 2 },
        { name = "emoji",                    insert = true },
        { name = "cmp_tabnine" },
        {
            name = "spell",
            {
                name = 'spell',
                option = {
                    keep_all_entries = false,
                    enable_in_context = function()
                        return true
                    end,
                },
            },
        },

    },
}
local lspkind = require('lspkind')
lspkind.init({
    mode = 'symbol_text',
    preset = 'codicons',
    symbol_map = {
        Text = "",
        Method = "",
        Function = "",
        Constructor = "",
        Field = "ﰠ",
        Variable = "",
        Class = "ﴯ",
        Interface = "",
        Module = "",
        Property = "ﰠ",
        Unit = "塞",
        Value = "",
        Enum = "",
        Keyword = "",
        Snippet = "",
        Color = "",
        File = "",
        Reference = "",
        Folder = "",
        EnumMember = "",
        Constant = "",
        Struct = "פּ",
        Event = "",
        Operator = "",
        TypeParameter = ""
    },
})

local tabnine = require('cmp_tabnine.config')

tabnine:setup({
    max_lines = 1000,
    max_num_results = 20,
    sort = true,
    run_on_every_keystroke = true,
    snippet_placeholder = '..',
    ignored_file_types = {
        rust = true
    },
    show_prediction_strength = true
})

local minisurround = require('mini.surround')
minisurround.setup()
