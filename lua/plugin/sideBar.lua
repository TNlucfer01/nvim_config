-- plugins/init.lua (lazy.nvim example)
-- ~/.config/nvim/lua/plugins/neotree.lua
return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("neo-tree").setup({
				close_if_last_window = true,
				popup_border_style = "rounded",
				enable_git_status = true,
				enable_diagnostics = true,
				filesystem = {
					filtered_items = {
						visible = true,
						hide_dotfiles = false,
						hide_gitignored = true,
					},
					follow_current_file = {
						enabled = true,
					},
					use_libuv_file_watcher = true,
				},
				buffers = {
					follow_current_file = {
						enabled = true,
					},
				},
				event_handlers = {
					{
						event = "file_opened",
						handler = function()
							require("neo-tree.command").execute({ action = "close" })
						end,
					},
				},
			})
		vim.keymap.set("n", "<C-l>", ":Neotree filesystem reveal left<CR>", {})
		vim.keymap.set("n", "<leader>bf", ":Neotree buffers reveal float<CR>", {})
		end,
	}
,
{
  "nvim-tree/nvim-tree.lua",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    require("nvim-tree").setup()
    -- Keymap: Ctrl + l to toggle NvimTree
    vim.keymap.set("n", "<C-l>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
  end,
}
-- ,{
--   "stevearc/oil.nvim",
--   dependencies = { "nvim-tree/nvim-web-devicons" },
--   config = function()
--     require("oil").setup()
--     -- Keymap: Ctrl + l to open Oil in current dir
--     vim.keymap.set("n", "<C-l>", require("oil").open, { desc = "Open Oil" })
--   end,
-- }
--
}

