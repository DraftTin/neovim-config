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
                capabilities = capabilities,
            },
            html = {
                capabilities = capabilities,
            },
            ts_ls = {
                capabilities = capabilities,
            },
            cssls = {
                capabilities = capabilities,
            },
            tailwindcss = {
                capabilities = capabilities,
            },
            svelte = {
                on_attach = function(client, bufnr)
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
                capabilities = capabilities,
            },
            graphql = {
                capabilities = capabilities,
                filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
            },
            emmet_ls = {
                capabilities = capabilities,
                filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
            },
            pyright = {
                capabilities = capabilities,
                settings = {
                    python = {
                        pythonPath = "/Users/ningyuheng/.pyenv/versions/neovim/bin/python",
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
