-- Colorscheme generated by https://github.com/arcticlimer/djanho
vim.cmd[[highlight clear]]

local highlight = function(group, bg, fg, attr)
    fg = fg and 'guifg=' .. fg or ''
    bg = bg and 'guibg=' .. bg or ''
    attr = attr and 'gui=' .. attr or ''

    vim.api.nvim_command('highlight ' .. group .. ' '.. fg .. ' ' .. bg .. ' '.. attr)
end

local link = function(target, group)
    vim.api.nvim_command('highlight! link ' .. target .. ' '.. group)
end

local Color1 = '#FDB849'
local Color0 = '#424242'
local Color7 = '#0e0e0e'
local Color4 = '#46ACAD'
local Color9 = '#251215'
local Color10 = '#311442'
local Color5 = '#eaac8b'
local Color3 = '#d34e6d'
local Color11 = '#222222'
local Color6 = '#717374'
local Color8 = '#0d251c'
local Color2 = '#e2b08c'

highlight('Comment', nil, Color0, 'italic')
highlight('Function', nil, Color1, nil)
highlight('Type', nil, Color2, nil)
highlight('Identifier', nil, Color3, nil)
highlight('Keyword', nil, Color4, 'bold')
highlight('Operator', nil, Color4, 'bold')
highlight('Type', nil, Color4, 'bold')
highlight('Constant', nil, Color5, nil)
highlight('StatusLine', Color6, Color7, nil)
highlight('WildMenu', Color7, nil, nil)
highlight('Pmenu', Color7, nil, nil)
highlight('PmenuSel', nil, Color7, nil)
highlight('PmenuThumb', Color7, nil, nil)
highlight('DiffAdd', Color8, nil, nil)
highlight('DiffDelete', Color9, nil, nil)
highlight('Normal', Color7, nil, nil)
highlight('Visual', Color10, nil, nil)
highlight('CursorLine', Color10, nil, nil)
highlight('ColorColumn', Color10, nil, nil)
highlight('SignColumn', Color7, nil, nil)
highlight('LineNr', nil, Color11, nil)
highlight('TabLine', Color7, nil, nil)
highlight('TabLineSel', nil, Color7, nil)
highlight('TabLineFill', Color7, nil, nil)

link('TSLabel', 'Type')
link('TSFunction', 'Function')
link('TSPunctSpecial', 'TSPunctDelimiter')
link('TSString', 'String')
link('Whitespace', 'Comment')
link('CursorLineNr', 'Identifier')
link('TSOperator', 'Operator')
link('TSTag', 'MyTag')
link('TSTagDelimiter', 'Type')
link('TSFloat', 'Number')
link('TSPunctBracket', 'MyTag')
link('TSNamespace', 'TSType')
link('TSParameter', 'Constant')
link('Operator', 'Keyword')
link('TSConditional', 'Conditional')
link('TSParameterReference', 'TSParameter')
link('TSKeyword', 'Keyword')
link('NonText', 'Comment')
link('Macro', 'Function')
link('TSConstBuiltin', 'TSVariableBuiltin')
link('TSComment', 'Comment')
link('TSField', 'Constant')
link('Conditional', 'Operator')
link('TSFuncMacro', 'Macro')
link('TelescopeNormal', 'Normal')
link('Repeat', 'Conditional')
link('TSProperty', 'TSField')
link('Folded', 'Comment')
link('TSType', 'Type')
link('TSRepeat', 'Repeat')
link('TSConstant', 'Constant')
link('TSNumber', 'Number')
