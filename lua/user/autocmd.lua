vim.api.nvim_create_autocmd("FocusGained", {
	command = "checktime",
})

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ timeout = 200 })
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

--[[vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.lua",
  callback = function()
    vim.lsp.buf.format()
  end,
})]]

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.md",
	command = "set filetype=markdown",
})

vim.api.nvim_create_autocmd("VimResized", {
	command = "tabdo wincmd =",
})

vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		local line = vim.fn.line("'\"")
		if line > 0 and line <= vim.fn.line("$") then
			vim.cmd("normal! g'\"")
		end
	end,
})
