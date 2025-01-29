return {
    "stevearc/conform.nvim",
    opts = {
        default_format_opts = {
            lsp_format = "fallback",
        },
        formatters_by_ft = {
            lua = { "stylua" },
            python = { "isort", "black", "rustywind" },
            sql = { "sql_formatter" },
            html = { "rustywind" }
        },
    },
    config = function(_, opts)
        local conform = require("conform")
        conform.setup(opts)

        vim.keymap.set("n", "<leader>df", conform.format)
    end
}
