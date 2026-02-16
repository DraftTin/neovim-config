return {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
        -- configuration (from main branch API: require("nvim-treesitter-textobjects").setup)
        require("nvim-treesitter-textobjects").setup({
            select = {
                lookahead = true,
            },
            move = {
                set_jumps = true,
            },
        })

        local select = require("nvim-treesitter-textobjects.select")
        local swap = require("nvim-treesitter-textobjects.swap")
        local move = require("nvim-treesitter-textobjects.move")
        local map = vim.keymap.set

        -- SELECT textobjects (keymaps use select.select_textobject(capture, query_group))

        -- assignment
        map({ "x", "o" }, "a=", function() select.select_textobject("@assignment.outer", "textobjects") end, { desc = "Select outer part of an assignment" })
        map({ "x", "o" }, "i=", function() select.select_textobject("@assignment.inner", "textobjects") end, { desc = "Select inner part of an assignment" })
        map({ "x", "o" }, "l=", function() select.select_textobject("@assignment.lhs", "textobjects") end, { desc = "Select left hand side of an assignment" })
        map({ "x", "o" }, "r=", function() select.select_textobject("@assignment.rhs", "textobjects") end, { desc = "Select right hand side of an assignment" })

        -- property (custom capture for javascript/typescript)
        map({ "x", "o" }, "a:", function() select.select_textobject("@property.outer", "textobjects") end, { desc = "Select outer part of an object property" })
        map({ "x", "o" }, "i:", function() select.select_textobject("@property.inner", "textobjects") end, { desc = "Select inner part of an object property" })
        map({ "x", "o" }, "l:", function() select.select_textobject("@property.lhs", "textobjects") end, { desc = "Select left part of an object property" })
        map({ "x", "o" }, "r:", function() select.select_textobject("@property.rhs", "textobjects") end, { desc = "Select right part of an object property" })

        -- parameter
        map({ "x", "o" }, "aa", function() select.select_textobject("@parameter.outer", "textobjects") end, { desc = "Select outer part of a parameter/argument" })
        map({ "x", "o" }, "ia", function() select.select_textobject("@parameter.inner", "textobjects") end, { desc = "Select inner part of a parameter/argument" })

        -- conditional
        map({ "x", "o" }, "ai", function() select.select_textobject("@conditional.outer", "textobjects") end, { desc = "Select outer part of a conditional" })
        map({ "x", "o" }, "ii", function() select.select_textobject("@conditional.inner", "textobjects") end, { desc = "Select inner part of a conditional" })

        -- loop
        map({ "x", "o" }, "al", function() select.select_textobject("@loop.outer", "textobjects") end, { desc = "Select outer part of a loop" })
        map({ "x", "o" }, "il", function() select.select_textobject("@loop.inner", "textobjects") end, { desc = "Select inner part of a loop" })

        -- function call
        map({ "x", "o" }, "af", function() select.select_textobject("@call.outer", "textobjects") end, { desc = "Select outer part of a function call" })
        map({ "x", "o" }, "if", function() select.select_textobject("@call.inner", "textobjects") end, { desc = "Select inner part of a function call" })

        -- method/function definition
        map({ "x", "o" }, "am", function() select.select_textobject("@function.outer", "textobjects") end, { desc = "Select outer part of a method/function definition" })
        map({ "x", "o" }, "im", function() select.select_textobject("@function.inner", "textobjects") end, { desc = "Select inner part of a method/function definition" })

        -- class
        map({ "x", "o" }, "ac", function() select.select_textobject("@class.outer", "textobjects") end, { desc = "Select outer part of a class" })
        map({ "x", "o" }, "ic", function() select.select_textobject("@class.inner", "textobjects") end, { desc = "Select inner part of a class" })

        -- SWAP (keymaps use swap.swap_next/swap_previous(capture))
        map("n", "<leader>na", function() swap.swap_next("@parameter.inner") end, { desc = "Swap parameter with next" })
        map("n", "<leader>n:", function() swap.swap_next("@property.outer") end, { desc = "Swap object property with next" })
        map("n", "<leader>nm", function() swap.swap_next("@function.outer") end, { desc = "Swap function with next" })
        map("n", "<leader>pa", function() swap.swap_previous("@parameter.inner") end, { desc = "Swap parameter with previous" })
        map("n", "<leader>p:", function() swap.swap_previous("@property.outer") end, { desc = "Swap object property with previous" })
        map("n", "<leader>pm", function() swap.swap_previous("@function.outer") end, { desc = "Swap function with previous" })

        -- MOVE (keymaps use move.goto_next_start/goto_next_end/etc(capture, query_group))
        -- goto next start
        map({ "n", "x", "o" }, "]f", function() move.goto_next_start("@call.outer", "textobjects") end, { desc = "Next function call start" })
        map({ "n", "x", "o" }, "]m", function() move.goto_next_start("@function.outer", "textobjects") end, { desc = "Next method/function def start" })
        map({ "n", "x", "o" }, "]c", function() move.goto_next_start("@class.outer", "textobjects") end, { desc = "Next class start" })
        map({ "n", "x", "o" }, "]i", function() move.goto_next_start("@conditional.outer", "textobjects") end, { desc = "Next conditional start" })
        map({ "n", "x", "o" }, "]l", function() move.goto_next_start("@loop.outer", "textobjects") end, { desc = "Next loop start" })
        map({ "n", "x", "o" }, "]s", function() move.goto_next_start("@local.scope", "locals") end, { desc = "Next scope" })
        map({ "n", "x", "o" }, "]z", function() move.goto_next_start("@fold", "folds") end, { desc = "Next fold" })
        -- goto next end
        map({ "n", "x", "o" }, "]F", function() move.goto_next_end("@call.outer", "textobjects") end, { desc = "Next function call end" })
        map({ "n", "x", "o" }, "]M", function() move.goto_next_end("@function.outer", "textobjects") end, { desc = "Next method/function def end" })
        map({ "n", "x", "o" }, "]C", function() move.goto_next_end("@class.outer", "textobjects") end, { desc = "Next class end" })
        map({ "n", "x", "o" }, "]I", function() move.goto_next_end("@conditional.outer", "textobjects") end, { desc = "Next conditional end" })
        map({ "n", "x", "o" }, "]L", function() move.goto_next_end("@loop.outer", "textobjects") end, { desc = "Next loop end" })
        -- goto previous start
        map({ "n", "x", "o" }, "[f", function() move.goto_previous_start("@call.outer", "textobjects") end, { desc = "Prev function call start" })
        map({ "n", "x", "o" }, "[m", function() move.goto_previous_start("@function.outer", "textobjects") end, { desc = "Prev method/function def start" })
        map({ "n", "x", "o" }, "[c", function() move.goto_previous_start("@class.outer", "textobjects") end, { desc = "Prev class start" })
        map({ "n", "x", "o" }, "[i", function() move.goto_previous_start("@conditional.outer", "textobjects") end, { desc = "Prev conditional start" })
        map({ "n", "x", "o" }, "[l", function() move.goto_previous_start("@loop.outer", "textobjects") end, { desc = "Prev loop start" })
        -- goto previous end
        map({ "n", "x", "o" }, "[F", function() move.goto_previous_end("@call.outer", "textobjects") end, { desc = "Prev function call end" })
        map({ "n", "x", "o" }, "[M", function() move.goto_previous_end("@function.outer", "textobjects") end, { desc = "Prev method/function def end" })
        map({ "n", "x", "o" }, "[C", function() move.goto_previous_end("@class.outer", "textobjects") end, { desc = "Prev class end" })
        map({ "n", "x", "o" }, "[I", function() move.goto_previous_end("@conditional.outer", "textobjects") end, { desc = "Prev conditional end" })
        map({ "n", "x", "o" }, "[L", function() move.goto_previous_end("@loop.outer", "textobjects") end, { desc = "Prev loop end" })

        -- REPEATABLE MOVE (from main branch: uses builtin_f_expr with { expr = true })
        local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")
        map({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
        map({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
        map({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
        map({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
        map({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
        map({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
    end,
}
