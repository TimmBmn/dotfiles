return {
    {
        "catppuccin/nvim",
        lazy = false,
        name = "catppuccin",
        priority = 1000,
        config = function ()
            vim.cmd.colorscheme("catppuccin-frappe")
        end
    },
    {
        "navarasu/onedark.nvim",
        lazy=true,
        opts = {
            style = "deep"
        }
    }
}
