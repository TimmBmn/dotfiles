return {
    { 'nvim-lua/plenary.nvim', lazy = true },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        -- TODO change how the pickers are displayed. I don't like the preview window only being like 2/6 of the screen.
        opts = {
            defaults = {
                vimgrep_arguments = {
                    -- default options from *telescope.defaults.vimgrep_arguments*
                    "rg",
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",

                    -- show hidden but ignore .git
                    "--hidden",
                    "--glob",
                    "!**/.git/*"
                },
                -- TODO decide if you like that
                -- the next 4 lines would change the way telescope displays each result.
                -- path_display = function(_, path)
                --     local tail = require("telescope.utils").path_tail(path)
                --     return string.format("%s (%s)", tail, path)
                -- end,
            },
            pickers = {
                find_files = {
                    find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
                },
            },
        },
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<CR>",                mode = "n" },
            { "<leader>fg", "<cmd>Telescope live_grep<CR>",                 mode = "n" },
            { "<leader>fb", "<cmd>Telescope buffers<CR>",                   mode = "n" },
            { "<leader>gs", "<cmd>Telescope git_status<CR>",                mode = "n" },
            { "<leader>ht", "<cmd>Telescope help_tags<CR>",                 mode = "n" },
            { "<leader>fw", "<cmd>Telescope grep_string<CR>",               mode = "n" },
            { "<leader>/",  "<cmd>Telescope current_buffer_fuzzy_find<CR>", mode = "n" },
        }
    }
}
