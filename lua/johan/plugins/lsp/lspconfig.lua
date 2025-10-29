return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
    },
    config = function()
        -- import cmp-nvim-lsp plugin (for capabilities)
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        local keymap = vim.keymap
        local opts = { noremap = true, silent = true }

        local on_attach = function(client, bufnr)
            opts.buffer = bufnr

            -- keybinds (unchanged)
            opts.desc = "Show LSP references"
            keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

            opts.desc = "Go to declaration"
            keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

            opts.desc = "Show LSP definitions"
            keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

            opts.desc = "Show LSP implementations"
            keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

            opts.desc = "Show LSP type definitions"
            keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

            opts.desc = "See available code actions"
            keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

            opts.desc = "Smart rename"
            keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

            opts.desc = "Show buffer diagnostics"
            keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

            opts.desc = "Show line diagnostics"
            keymap.set("n", "<leader>sd", vim.diagnostic.open_float, opts)

            opts.desc = "Go to previous diagnostic"
            keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

            opts.desc = "Go to next diagnostic"
            keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

            opts.desc = "Show documentation under cursor"
            keymap.set("n", "K", vim.lsp.buf.hover, opts)

            opts.desc = "Restart LSP"
            keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
        end

        -- capabilities for autocompletion
        local capabilities = cmp_nvim_lsp.default_capabilities()

        -- diagnostic signs (unchanged)
        vim.diagnostic.config({
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = " ",
                    [vim.diagnostic.severity.WARN] = " ",
                    [vim.diagnostic.severity.HINT] = "󰠠 ",
                    [vim.diagnostic.severity.INFO] = " ",
                },
            },
            virtual_text = { prefix = "●" },
            float = { border = "rounded" },
            severity_sort = true,
        })

        -- per-server configs (what used to be lspconfig[server].setup{...})
        local servers = {
            gopls = {
                on_attach = on_attach,
                capabilities = capabilities,
            },
            html = {
                on_attach = on_attach,
                capabilities = capabilities,
            },
            ts_ls = {
                on_attach = on_attach,
                capabilities = capabilities,
            },
            cssls = {
                on_attach = on_attach,
                capabilities = capabilities,
            },
            tailwindcss = {
                on_attach = on_attach,
                capabilities = capabilities,
            },
            svelte = {
                on_attach = function(client, bufnr)
                    on_attach(client, bufnr)
                    vim.api.nvim_create_autocmd("BufWritePost", {
                        pattern = { "*.js", "*.ts" },
                        callback = function(ctx)
                            if client.name == "svelte" then
                                client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file })
                            end
                        end,
                    })
                end,
                capabilities = capabilities,
            },
            prismals = {
                on_attach = on_attach,
                capabilities = capabilities,
            },
            graphql = {
                on_attach = on_attach,
                capabilities = capabilities,
                filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
            },
            emmet_ls = {
                on_attach = on_attach,
                capabilities = capabilities,
                filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
            },
            pyright = {
                on_attach = on_attach,
                capabilities = capabilities,
                -- make sure pyright has a root (so it loads settings)
                -- root_dir = function(fname)
                --     return vim.fs.root(fname, { "pyproject.toml", "setup.cfg", "setup.py", "requirements.txt", ".git" })
                --         or vim.fs.dirname(fname)
                -- end,
                settings = {
                    python = {
                        -- either set pythonPath directly:
                        pythonPath = "/Users/ningyuheng/.pyenv/versions/neovim/bin/python",

                        -- optionally also give venv info so it can auto-detect:
                        venvPath = "/Users/ningyuheng/.pyenv/versions",
                        venv = "neovim",

                        analysis = {
                            autoSearchPaths = true,
                            diagnosticMode = "openFilesOnly",
                            useLibraryCodeForTypes = true,
                        },
                    },
                },
            },
            lua_ls = {
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = { globals = { "vim" } },
                        workspace = {
                            library = {
                                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                                [vim.fn.stdpath("config") .. "/lua"] = true,
                            },
                        },
                    },
                },
            },
            rust_analyzer = {
                on_attach = on_attach,
                settings = {
                    cargo = {
                        allFeatures = true,
                        loadOutDirsFromCheck = true,
                    },
                    procMacro = { enable = true },
                },
            },
        }

        -- register and enable all servers via Neovim 0.11 API
        for name, cfg in pairs(servers) do
            vim.lsp.config(name, cfg)
        end
        vim.lsp.enable(vim.tbl_keys(servers))
    end,
}
