return {
	{
		"mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")
			-- Basic setup (optional, can be omitted if using default settings)
			dap.setup()
			-- Keybindings
			vim.keymap.set("n", "<F5>", dap.continue, { desc = "DAP: Start/Continue" })
			vim.keymap.set("n", "<F10>", dap.step_over, { desc = "DAP: Step over" })
			vim.keymap.set("n", "<F11>", dap.step_into, { desc = "DAP: Step into" })
			vim.keymap.set("n", "<F12>", dap.step_out, { desc = "DAP: Step out" })
			vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "DAP: Toggle breakpoint" })
			vim.keymap.set("n", "<leader>B", function()
				dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end, { desc = "DAP: Set conditional breakpoint" })
			vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "DAP: Open REPL" })
			vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "DAP: Run last" })
		end,
	},
	{
		"jbyuki/one-small-step-for-vimkind", -- Lua debugger
		dependencies = { "mfussenegger/nvim-dap" },
		config = function()
			require("osv").setup()
			require("dap").configurations.lua = {
				{
					type = "nlua",
					request = "attach",
					name = "Attach to running Neovim instance",
				},
			}
		end,
	},
	{
		"theHamsta/nvim-dap-virtual-text", -- Show variable values in the code
		dependencies = { "mfussenegger/nvim-dap" },
		config = function()
			require("nvim-dap-virtual-text").setup()
		end,
	},
	{
		"rcarriga/nvim-dap-ui", -- UI for DAP
		dependencies = { "mfussenegger/nvim-dap" },
		config = function()
			require("dapui").setup({
				controls = {
					element = "repl",
					enabled = true,
					icons = {
						pause = "⏸",
						play = "▶",
						step_into = "⏎",
						step_over = "⏭",
						step_out = "⏮",
						step_back = "⏪",
						run_last = "↻",
						terminate = "⏹",
					},
				},
			})
			-- Auto-open DAP UI when debugging starts
			require("dap").listeners.after.event_initialized["dapui_config"] = function()
				require("dapui").open()
			end
			require("dap").listeners.before.event_terminated["dapui_config"] = function()
				require("dapui").close()
			end
			require("dap").listeners.before.event_exited["dapui_config"] = function()
				require("dapui").close()
			end
		end,
	},
	{
		"mason-org/mason.nvim",
		opts = { ensure_installed = { "java-debug-adapter", "java-test", "debugpy" } },
	},
}
