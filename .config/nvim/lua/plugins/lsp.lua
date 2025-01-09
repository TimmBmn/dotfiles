-- TODO add snipped engine and check what it actually does (e.g. LuaSnip)
return {
    { "williamboman/mason.nvim", opts = {} },
    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            ensure_installed = { "lua_ls", "pyright", "emmet_language_server" },
        }
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "j-hui/fidget.nvim",   opts = {} },
            { "hrsh7th/cmp-nvim-lsp" },
            {
                "hrsh7th/nvim-cmp",
                dependencies = {
                    { "hrsh7th/cmp-nvim-lsp-signature-help" },
                    { "hrsh7th/cmp-buffer" },
                    { "hrsh7th/cmp-path" },
                    { "hrsh7th/cmp-cmdline" }
                },
                config = function()
                    local cmp = require("cmp")
                    cmp.setup({
                        window = {
                            completion = cmp.config.window.bordered(),
                            documentation = cmp.config.window.bordered(),
                        },
                        sources = {
                            { name = "nvim_lsp" },
                            { name = "nvim_lsp_signature_help" },
                            { name = "buffer" },
                            { name = "path" }
                        },
                        mapping = cmp.mapping.preset.insert({
                            -- these are the only two i am actively using right now
                            -- in the future i'll probably add the scrolling through docs
                            -- but for now its enough
                            ['<C-Space>'] = cmp.mapping.complete(),
                            ['<CR>'] = cmp.mapping.confirm({ select = false }),
                            --['<C-b>'] = cmp.mapping.scroll_docs(-4),
                            --['<C-f>'] = cmp.mapping.scroll_docs(4),
                            --['<C-e>'] = cmp.mapping.abort(),
                        }),
                    })

                    cmp.setup.cmdline({ "/", "?" }, {
                        mapping = cmp.mapping.preset.cmdline(),
                        sources = {
                            { name = "buffer" },
                        }
                    })

                    cmp.setup.cmdline(":", {
                        mapping = cmp.mapping.preset.cmdline(),
                        sources = {
                            { name = "path" },
                            { name = "cmdline" }
                        }
                    })
                end,
            },
        },
        config = function()
            local lspconfig = require("lspconfig")
            local mason_lspconfig = require("mason-lspconfig")
            local cmp_nvim_lsp = require("cmp_nvim_lsp")

            local capabilities = vim.tbl_deep_extend('force',
                vim.lsp.protocol.make_client_capabilities(),
                cmp_nvim_lsp.default_capabilities())

            mason_lspconfig.setup_handlers({
                -- default handler for installed servers
                function(server_name)
                    lspconfig[server_name].setup({
                        capabilities = capabilities
                    })
                end,
            })

            -- TODO figure out if you like it with the normal functions or if you want to use telescope
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(buffer)
                    local opts = { buffer = buffer.buf }
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                    vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
                    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
                    vim.keymap.set("n", "<leader>vr", vim.lsp.buf.rename, opts)
                end

            })
        end,
    }
}
