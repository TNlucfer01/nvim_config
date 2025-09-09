return {
	-- Core DAP
	{
		"mfussenegger/nvim-dap",
		config = function()
			-- You can add custom dap.adapter setup here later if needed
		end,
	},

	-- DAP UI
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio", -- Required
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			dapui.setup()

			-- Auto open/close dap-ui
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
	},

	-- Mason DAP
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap",
		},
		config = function()
			require("mason-nvim-dap").setup({
				ensure_installed = { "stylua", "jq" },
				handlers = {
					function(config)
						-- all sources with no handler get passed here

						-- Keep original functionality
						require("mason-nvim-dap").default_setup(config)
					end,
					python = function(config)
						config.adapters = {
							type = "executable",
							command = "/usr/bin/python3",
							args = {
								"-m",
								"debugpy.adapter",
							},
						}
						require("mason-nvim-dap").default_setup(config) -- don't forget this!
					end,
				},
			})

			-- If you want to customize handlers, you can:

			-- Optional: Add your own config here if needed
		end,
	},
}
