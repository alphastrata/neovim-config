-- NOTE: KEYBINDINGS, these will not be for you viewer, unless you use a colemak layout.
local opts = { noremap = true, silent = true }

-- helper func to reduce typing
local keymap = vim.api.nvim_set_keymap


-- colemak bindings hnei for hjklitTlNEI
keymap("n", "h", "h", opts)
keymap("n", "n", "j", opts)
keymap("n", "e", "k", opts)
keymap("n", "i", "l", opts)
keymap("n", "t", "i", opts)
keymap("n", "T", "I", opts)
keymap("n", "l", "o", opts)
keymap("n", "N", "B", opts)
keymap("n", "E", "}", opts)
keymap("n", "I", "{", opts)

-- because lua doesn't respect my noremaps>
keymap("v", "h", "h", opts)
keymap("v", "n", "j", opts)
keymap("v", "e", "k", opts)
keymap("v", "i", "l", opts)
keymap("v", "t", "i", opts)
keymap("v", "T", "I", opts)
keymap("v", "l", "o", opts)
keymap("v", "N", "B", opts)
keymap("v", "E", "}", opts)
keymap("v", "I", "{", opts)
-- because lua doesn't respect >
keymap("x", "h", "h", opts)
keymap("x", "n", "j", opts)
keymap("x", "e", "k", opts)
keymap("x", "i", "l", opts)
keymap("x", "t", "i", opts)
keymap("x", "T", "I", opts)
keymap("x", "l", "o", opts)
keymap("x", "N", "B", opts)
keymap("x", "E", "}", opts)
keymap("x", "I", "{", opts)
