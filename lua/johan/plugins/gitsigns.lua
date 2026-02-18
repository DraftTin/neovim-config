return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local gs = require("gitsigns")
        local map = vim.keymap.set

        -- Navigation between hunks
        map("n", "]h", gs.next_hunk, { desc = "Next hunk" })
        map("n", "[h", gs.prev_hunk, { desc = "Prev hunk" })

        -- Preview & diff
        map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })
        map("n", "<leader>hd", gs.diffthis, { desc = "Diff against index" })
        map("n", "<leader>hD", function()
            gs.diffthis("~1")
        end, { desc = "Diff against last commit" })

        -- Blame
        map("n", "<leader>hb", gs.blame_line, { desc = "Blame line" })
    end,
}
