return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" },
		config = function()
			require("neo-tree").setup({
				close_if_last_window = true,
				popup_border_style = "rounded",
				enable_git_status = true,
				enable_diagnostics = true,
				filesystem = {
					filtered_items = { visible = true, hide_dotfiles = false, hide_gitignored = true },
					follow_current_file = { enabled = true }, -- disable libuv watcher (can block mv)
					use_libuv_file_watcher = false, -- enable built-in commands
					hijack_netrw_behavior = "open_default",
					commands = {}, -- keep defaults (has move included)
				},
				buffers = { follow_current_file = { enabled = true } },
				event_handlers = {
					{
						event = "file_opened",
						handler = function()
							require("neo-tree.command").execute({ action = "close" })
						end,
					},
				},
			})
			-- keymaps
			vim.keymap.set("n", "<C-l>", ":Neotree filesystem reveal left<CR>", {})
			vim.keymap.set("n", "<leader>bf", ":Neotree buffers reveal float<CR>", {})
		end,
	},
}
