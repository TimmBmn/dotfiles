return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        on_attach = function(bufnr)
            local opts = { buffer = bufnr}

            local gitsigns = require("gitsigns")
            vim.keymap.set("n", "<leader>gbl", gitsigns.blame_line, opts)
            vim.keymap.set("n", "<leader>gba", gitsigns.blame, opts)
        end
    }
}
