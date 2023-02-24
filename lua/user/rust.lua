-- RUSTTOOLS:
local rt = require("rust-tools")

rt.setup({
    server = {
        on_attach = function(_, bufnr)
            -- Hover actions
            vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
            -- Code action groups
            vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })

            -- Move an Item up or down
            -- vim.keymap.set("n", "<Leader><Up>", rt.move_item.move_item(true), { buffer = bufnr })
            -- vim.keymap.set("n", "<Leader><Down>", rt.move_item.move_item(false), { buffer = bufnr })
        end,
    },
})
