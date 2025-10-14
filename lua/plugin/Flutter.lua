return {
	{
		"akinsho/flutter-tools.nvim",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"stevearc/dressing.nvim", -- optional for vim.ui.select
		},
		config = function()
			require("flutter-tools").setup({
				-- you can add settings here if you want
				flutter_path = "flutter", -- make sure flutter is in PATH
				lsp = {
					color = {
						enabled = true,
					},
				},
			})
		end,
	},
}
