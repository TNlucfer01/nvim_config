-- lua/plugins/telescope.lua
return {
	{
		"nvim-telescope/telescope.nvim", -- Plugin name
		tag = "0.1.8", -- Tag or version to use
		dependencies = { "nvim-lua/plenary.nvim" }, -- Dependencies
		config = function() -- Configuration function
			require("telescope").setup({
				defaults = {
					-- Your Telescope default configurations here
					file_ignore_patterns = { "node_modules", ".git/" },
				},
			})

			-- Keymaps for Telescope
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
			vim.keymap.set("n", "<leader><leader>", builtin.oldfiles, {})
	    vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
	end,
	}, -- for the
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
}
