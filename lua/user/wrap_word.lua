function get_selection(start_line, start_col, end_line, end_col)
    local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
    local selected_lines = {}

    if start_col > 0 then
        table.insert(selected_lines, string.sub(lines[1], start_col))
    else
        table.insert(selected_lines, lines[1])
    end

    for i = 2, #lines - 1 do
        table.insert(selected_lines, lines[i])
    end

    if end_col > 0 then
        table.insert(selected_lines, string.sub(lines[#lines], 1, end_col))
    elseif #lines > 1 then
        table.insert(selected_lines, lines[#lines - 1])
    else
        table.insert(selected_lines, lines[1])
    end

    return table.concat(selected_lines, "\n")
end

function get_highlighted()
    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")
    --TODO: make the start_line an int here so we can -1 from it at this stage.
    local start_line = start_pos[2]
    local start_col = start_pos[3]
    local end_line = end_pos[2]
    local end_col = end_pos[3]

    return start_line, start_col, end_line, end_col
end

function wrap_selection()
    local start_line, start_col, end_line, end_col = get_highlighted()

    local initial = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)

    if start_line == end_line then
        initial = vim.api.nvim_buf_get_lines(0, start_line - 1, start_line - 1, false)
    end

    local selection = get_selection(start_line, start_col, end_line, end_col)

    initial = table.concat(initial, "\n")
    print("initial:\n" .. initial)
    print("---------------------------------------")

    local choice = vim.fn.input('Enter bracket pair: \n') --, '', 'customlist, noselect', 'silent')

    if choice == nil then
        return
    end

    local brackets = {
        ['{'] = { opening = '{', closing = '}' },
        ['('] = { opening = '(', closing = ')' },
        ['['] = { opening = '[', closing = ']' },
        ['<'] = { opening = '<', closing = '>' },
        ['"'] = { opening = '"', closing = '"' },
        ["'"] = { opening = "'", closing = "'" },
        ['*'] = { opening = '*', closing = '*' },
        ['_'] = { opening = '_', closing = '_' },
    }

    local opening, closing = brackets[choice].opening, brackets[choice].closing;

    local replace = string.format('%s%s%s', opening, selection, closing)
    print("wrapped: \n" .. replace)
    print("---------------------------------------")
    local output = string.gsub(initial, selection, wrapped_selection)
    print("output: \n" .. output)
    print("---------------------------------------")

    replace_selection(search, replace, start_line, start_col, end_line, end_col)
end

function replace_selection(search, replace, start_line, start_col, end_line, end_col)
    local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
    local selection = table.concat(lines, "\n"):sub(start_col, end_col)

    -- Perform the substitution
    local bufnr = vim.fn.bufnr('%')
    local replaced = string.gsub(selection, search, replace)

    -- Update the buffer with the substituted text
    vim.api.nvim_buf_set_text(bufnr, start_line - 1, start_col - 1, end_line, end_col, { replaced })
end

-- ws= wrap selection
vim.api.nvim_set_keymap('v', "<leader>ppp", ":lua wrap_selection()<CR>",
    { noremap = true, silent = true })

-- ws= wraprap
vim.api.nvim_set_keymap('v', "<leader>wr", "<Cmd>lua wrap_word()<CR>", { noremap = true, silent = true })



-- -- Simple setup to wrap words that you've selected in visual mode within some ticks/brackets etc
-- function cword()
--     return vim.fn.expand('<cword>')
-- end
--
-- function wrap_word()
--     local word = cword()
--     if word == '' then
--         return
--     end
--
--     local replace = string.format('%s%s%s', opening, selection, closing)
--     print("wrapped: \n" .. replace)
--     print("---------------------------------------")
--     local output = string.gsub(initial, selection, replace)
--     print("output: \n" .. output)
--     print("---------------------------------------")
--
--     replace_selection(search, replace, start_line, start_col, end_line, end_col)
-- end
--
-- function replace_selection(search, replace, start_line, start_col, end_line, end_col)
--     local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
--     local selection = table.concat(lines, "\n"):sub(start_col, end_col)
--
--     -- Perform the substitution
--     local bufnr = vim.fn.bufnr('%')
--     local replaced = string.gsub(selection, search, replace)
--
--     -- Update the buffer with the substituted text
--     vim.api.nvim_buf_set_text(bufnr, start_line - 1, start_col - 1, end_line, end_col, { replaced })
-- end

-- -- ws= wrap selection
-- vim.api.nvim_set_keymap('v', "<leader>ppp", ":lua wrap_selection()<CR>",
--     { noremap = true, silent = true })
-- --
-- -- -- ws= wraprap
-- -- vim.api.nvim_set_keymap('v', "<leader>wr", "<Cmd>lua wrap_word()<CR>", { noremap = true, silent = true })
-- -- vim.cmd(string.format('normal! ciw%s', wrapped_word))
