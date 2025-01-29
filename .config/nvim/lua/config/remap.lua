vim.keymap.set("n", "<esc>", "<cmd>nohlsearch<cr>", { silent = true })

vim.keymap.set({ "n", "v" }, "<leader>y", "\"+y")
vim.keymap.set({ "n", "v" }, "<leader>p", "\"+p")

-- TODO add more keymaps to e.g. open/close quick fix list
vim.keymap.set("n", "<C-j>", "<CMD>cnext<CR>")
vim.keymap.set("n", "<C-k>", "<CMD>cprev<CR>")
