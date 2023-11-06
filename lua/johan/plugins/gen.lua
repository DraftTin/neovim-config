return {
  "David-Kunz/gen.nvim",
  config = function()
    vim.keymap.set("v", "<leader>]", ":Gen<CR>", { desc = "gengen" })
    vim.keymap.set("n", "<leader>]", ":Gen<CR>", { desc = "gengen" })
    require("gen").model = "llama2"
    function ChangeModel()
      require("gen").model = vim.fn.input("model name: ")
    end
    vim.api.nvim_set_keymap("n", "<leader>=", "<cmd>lua ChangeModel()<CR>", { noremap = true, silent = true })
  end,
}
