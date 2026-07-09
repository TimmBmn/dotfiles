return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    main = "nvim-treesitter",
    opts = {
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = true,
        additional_vim_regex_highlighting = false
    },
    init = function(opts)
        print(opts)

        local ensureInstalled = {
            'lua', 'python', 'typescript', "html", "json", "htmldjango",
        }
        local alreadyInstalled = require('nvim-treesitter.config').get_installed()
        local parsersToInstall = vim.iter(ensureInstalled)
            :filter(function(parser)
                return not vim.tbl_contains(alreadyInstalled, parser)
            end)
            :totable()
        require('nvim-treesitter').install(parsersToInstall)

        vim.api.nvim_create_autocmd('FileType', {
            callback = function()
                -- Enable treesitter highlighting and disable regex syntax
                pcall(vim.treesitter.start)
                -- Enable treesitter-based indentation
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })
    end,
}
