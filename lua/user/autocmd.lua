--[[ //why ? ]]
vim.api.nvim_create_autocmd("FocusGained", {
	command = "checktime",
})
--[[ //for the highlight when selected ]]
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ timeout = 200 })
	end,
})
--[[ //for writing nd saving  ]]
-- vim.api.nvim_create_autocmd("BufWritePre", {
-- 	pattern = "*",
-- 	command = [[%s/\s\+$//e]],
-- })
--


--[[ //dont know why  ]]
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.md",
	command = "set filetype=markdown",
})

--[[ //dont know why ? ]]
vim.api.nvim_create_autocmd("VimResized", {
	command = "tabdo wincmd =",
})
--[[ //same prblm  ]]
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		local line = vim.fn.line("'\"")
		if line > 0 and line <= vim.fn.line("$") then
			vim.cmd("normal! g'\"")
		end
	end,
})
