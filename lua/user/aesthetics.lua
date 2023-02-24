require("transparent").setup({
    enable = true, -- boolean: enable transparent
    extra_groups = {
        "BufferLineTabClose",
        "BufferlineBufferSelected",
        "BufferLineFill",
        "BufferLineBackground",
        "BufferLineSeparator",
        "BufferLineIndicatorSelected",
    },
    exclude = {},
})

require("notify").setup({
    background_colour = "#282A36"
})
