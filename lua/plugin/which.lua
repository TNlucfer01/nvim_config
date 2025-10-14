return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").setup({
					win = {
						border = "single", -- Popup border style
						title = true, -- Show a title in the popup
					},
					layout = {
						align = "center", -- Align popup content
					},
				})
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
}
