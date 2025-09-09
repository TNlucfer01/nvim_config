return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		lazy = false,
		config = function()
			vim.cmd.colorscheme("catppuccin") -- Applies the colorscheme
		end,
	},

	{
		"nvim-tree/nvim-web-devicons", -- ✅ File icons

		config = function()
			require("nvim-web-devicons").setup({
				override = {},
				default = true,
			})
		end,
	},
}
