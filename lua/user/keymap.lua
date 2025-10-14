local map = vim.keymap.set
map("n", "<Space>", "", { noremap = true })
vim.g.mapleader = " "
map("n", "<leader>q", ":q<CR>", { desc = "Quit" })
map("n", "<leader>w", ":w<CR>", { desc = "Save" })
map("i", "jj", "<Esc>", { desc = "Exit insert mode quickly" })

map("v", "yc", '"+y', { noremap = true, silent = true })
