-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps -------------------

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- delete single character without copying into register
-- keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window
keymap.set(
    "n",
    "<leader>sg",
    "<C-w>v<cmd>FzfLua lsp_definitions<CR>",
    { desc = "Split window vertically and go to the definitions" }
)

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<Tab>", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<S-Tab>", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab
-- keymap.set("n", "<Tab>", function () vim.cmd("bnext") end, {desc = "move to the next file in the buffer"})
-- keymap.set("n", "<S-Tab>", function () vim.cmd("bprev") end, {desc = "move to the previous file in the buffer"})

-- select all content
keymap.set("n", "<leader>aa", "ggVG", { desc = "Select all content in the file" })
vim.api.nvim_set_keymap("n", "gj", "gj", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gk", "gk", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gh", "g0", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gl", "g$", { noremap = true, silent = true })

---------------------
-- LSP Keymaps (applied to all LSP clients, including umple)
---------------------
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local buf = ev.buf
        local function opts(desc)
            return { buffer = buf, noremap = true, silent = true, desc = desc }
        end

        keymap.set("n", "gR", "<cmd>FzfLua lsp_references<CR>", opts("Show LSP references"))
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts("Go to declaration"))
        keymap.set("n", "gd", "<cmd>FzfLua lsp_definitions<CR>", opts("Show LSP definitions"))
        keymap.set("n", "gi", "<cmd>FzfLua lsp_implementations<CR>", opts("Show LSP implementations"))
        keymap.set("n", "gt", "<cmd>FzfLua lsp_typedefs<CR>", opts("Show LSP type definitions"))
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts("See available code actions"))
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts("Smart rename"))
        keymap.set("n", "<leader>D", "<cmd>FzfLua diagnostics_document<CR>", opts("Show buffer diagnostics"))
        keymap.set("n", "<leader>sd", vim.diagnostic.open_float, opts("Show line diagnostics"))
        keymap.set("n", "[d", vim.diagnostic.goto_prev, opts("Go to previous diagnostic"))
        keymap.set("n", "]d", vim.diagnostic.goto_next, opts("Go to next diagnostic"))
        keymap.set("n", "K", vim.lsp.buf.hover, opts("Show documentation under cursor"))
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts("Restart LSP"))
    end,
})
