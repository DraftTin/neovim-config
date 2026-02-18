return {
    "ibhagwan/fzf-lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local fzf = require("fzf-lua")

        fzf.setup({
            winopts = {
                preview = {
                    layout = "flex",
                },
            },
            keymap = {
                fzf = {
                    ["ctrl-q"] = "select-all+accept",
                },
            },
        })

        local keymap = vim.keymap

        keymap.set("n", "<leader>fb", fzf.buffers, { desc = "Fzf buffers" })
        keymap.set("n", "<leader>ff", fzf.files, { desc = "Fuzzy find files in cwd" })
        keymap.set("n", "<leader>fr", fzf.oldfiles, { desc = "Fuzzy find recent files" })
        keymap.set("n", "<leader>fs", fzf.live_grep, { desc = "Find string in cwd" })
        keymap.set("n", "<leader>fc", fzf.grep_cword, { desc = "Find string under cursor in cwd" })
    end,
}
