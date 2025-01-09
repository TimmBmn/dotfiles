return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	main="nvim-treesitter.configs",
	opts = {
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "python" },
		sync_install = false,

		-- Automatically install missing parsers when entering buffer
		-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
		auto_install = true,

		highlight = {
			enable = true,
		},

        additional_vim_regex_highlighting = false
	}
}
