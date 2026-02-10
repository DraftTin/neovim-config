return {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    -- Optional dependencies
    dependencies = { { "nvim-mini/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
    config = function()
        require("oil").setup({
            keymaps = {
                -- Disable the default C-h and C-l to let tmux-navigator work
                ["<C-h>"] = false,
                ["<C-l>"] = false,

                -- Optional: You can still keep the functionality by mapping them elsewhere
                -- ["<C-x>"] = "actions.select_split",
            },
        })

        vim.keymap.set("n", "-", "<cmd>Oil<CR>")
    end,
}
