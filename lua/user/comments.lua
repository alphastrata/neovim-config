require('todo-comments').setup(
    {
        -- NOTE: basically the defaults.
        signs = true, -- show icons in the signs column
        sign_priority = 8, -- sign priority
        -- keywords recognized as todo comments
        keywords = {
            FIX = {
                icon = " ", -- icon used for the sign, and in search results
                color = "error", -- can be a hex color, or a named color (see below)
                alt = { "FIXME", "BUG", "FIXIT", "ISSUE", "PROBLEM" }, -- a set of other keywords that all map to this FIX keywords
                -- signs = false, -- configure signs for some keywords individually
            },
            TODO = { icon = " ", color = "info" },
            HACK = { icon = " ", color = "warning" },
            QUESTION = { icon = "", color = "warning" },
            WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
            PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMISE" } },
            NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        },
        merge_keywords = true, -- when true, custom keywords will be merged with the defaults
        -- highlighting of the line containing the todo comment
        -- * before: highlights before the keyword (typically comment characters)
        -- * keyword: highlights of the keyword
        -- * after: highlights after the keyword (todo text)
        highlight = {
            before = "empty", -- "fg" or "bg" or empty
            keyword = "bg", -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
            after = "fg", -- "fg" or "bg" or empty
            pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlightng (vim regex)
            comments_only = true, -- uses treesitter to match keywords in comments only
            max_line_len = 1900, -- ignore lines longer than this
            exclude = {}, -- list of file types to exclude highlighting
        },
        -- list of named colors where we try to extract the guifg from the
        -- list of hilight groups or use the hex color if hl not found as a fallback
        colors = {
            error = { "LspDiagnosticsDefaultError", "ErrorMsg", "#DC2626" },
            warning = { "LspDiagnosticsDefaultWarning", "WarningMsg", "#FBBF24" },
            info = { "LspDiagnosticsDefaultInformation", "#2563EB" },
            hint = { "LspDiagnosticsDefaultHint", "#10B981" },
            default = { "Identifier", "#7C3AED" },
        },
        search = {
            command = "rg",
            args = {
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
            },
            -- regex that will be used to match keywords.
            -- don't replace the (KEYWORDS) placeholder
            pattern = [[\b(KEYWORDS):]], -- ripgrep regex
            -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
        },
    }
)
-- Comment.nvim
require('Comment').setup(
    {
        -- NOTE: basically the defaults.
        ---Add a space b/w comment and the line
        ---@type boolean|fun():boolean
        padding = true,
        ---Whether the cursor should stay at its position
        ---NOTE: This only affects NORMAL mode mappings and doesn't work with dot-repeat
        ---@type boolean
        sticky = true,
        ---Lines to be ignored while comment/uncomment.
        ---Could be a regex string or a function that returns a regex string.
        ---Example: Use '^$' to ignore empty lines
        ---@type string|fun():string
        ignore = nil,
        ---LHS of toggle mappings in NORMAL + VISUAL mode
        ---@type table
        --NOTE: these are my only changes from the defaults...
        toggler = {
            ---Line-comment toggle keymap
            line = 'cl', --comment line(s)
            ---Block-comment toggle keymap
            block = 'gl',
        },
        ---LHS of operator-pending mappings in NORMAL + VISUAL mode
        ---@type table
        opleader = {
            ---Line-comment keymap
            line = 'cl',
            ---Block-comment keymap
            block = 'gl',
        },
        ---LHS of extra mappings
        ---@type table
        extra = {
            ---Add comment on the line above
            above = 'gcO',
            ---Add comment on the line below
            below = 'gco',
            ---Add comment at the end of line
            eol = 'gcA',
        },
        ---Create basic (operator-pending) and extended mappings for NORMAL + VISUAL mode
        ---NOTE: If `mappings = false` then the plugin won't create any mappings
        ---@type boolean|table
        mappings = {
            ---Operator-pending mapping
            ---Includes `gcc`, `gbc`, `gc[count]{motion}` and `gb[count]{motion}`
            ---NOTE: These mappings can be changed individually by `opleader` and `toggler` config
            basic = true,
            ---Extra mapping
            ---Includes `gco`, `gcO`, `gcA`
            extra = true,
            ---Extended mapping
            ---Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
            extended = false,
        },
        ---Pre-hook, called before commenting the line
        ---@type fun(ctx: CommentCtx):string
        pre_hook = nil,
        ---Post-hook, called after commenting is done
        ---@type fun(ctx: CommentCtx)
        post_hook = nil,
    }
)
