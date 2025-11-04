return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "auto", -- latte, frappe, macchiato, mocha
                background = { -- :h background
                    light = "latte",
                    dark = "macchiato",
                },
                transparent_background = true, -- disables setting the background color.
                float = {
                    transparent = true, -- enable transparent floating windows
                    solid = false, -- use solid styling for floating windows, see |winborder|
                },
                show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
                term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
                dim_inactve = {
                    enabled = false, -- dims the background color of inactive window
                    shade = "dark",
                    percentage = 0.15, -- percentage of the shade to apply to the inactive window
                },
                no_italic = false, -- Force no italic
                no_bold = false, -- Force no bold
                no_underline = false, -- Force no underline
                styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
                    comments = { "italic" }, -- Change the style of comments
                    conditionals = { "italic" },
                    loops = {},
                    functions = {},
                    keywords = {},
                    strings = {},
                    variables = {},
                    numbers = {},
                    booleans = {},
                    properties = {},
                    types = {},
                    operators = {},
                    -- miscs = {}, -- Uncomment to turn off hard-coded styles
                },
                color_overrides = {},
                custom_highlights = function(c)
                    return {
                        -- make non-current line numbers brighter
                        LineNr = { fg = c.overlay1 }, -- try overlay2 or subtext1 if you want even brighter
                        LineNrAbove = { fg = c.overlay1 },
                        LineNrBelow = { fg = c.overlay1 },

                        -- make the current line number pop
                        CursorLineNr = { fg = c.peach, bold = true },

                        -- optional: keep cursorline subtle when using transparency
                        CursorLine = { bg = "NONE" },
                    }
                end,
                default_integrations = true,
                integrations = {
                    cmp = true,
                    gitsigns = true,
                    nvimtree = true,
                    treesitter = true,
                    notify = false,
                    mini = {
                        enabled = true,
                        indentscope_color = "",
                    },
                    -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
                },
            })

            -- setup must be called before loading
            vim.cmd.colorscheme("catppuccin")
        end,
    },
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        config = function()
            -- Default options:
            require("gruvbox").setup({
                terminal_colors = true, -- add neovim terminal colors
                undercurl = true,
                underline = true,
                bold = true,
                italic = {
                    strings = true,
                    emphasis = true,
                    comments = true,
                    operators = true,
                    folds = true,
                },
                strikethrough = true,
                invert_selection = false,
                invert_signs = false,
                invert_tabline = false,
                inverse = true, -- invert background for search, diffs, statuslines and errors
                contrast = "", -- can be "hard", "soft" or empty string
                palette_overrides = {},
                overrides = {},
                dim_inactive = false,
                transparent_mode = true,
            })
            -- vim.cmd.colorscheme("gruvbox")
        end,
    },
}
