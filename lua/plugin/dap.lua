return {
	-- Core DAP
	{
		"mfussenegger/nvim-dap",
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
			local dap = require("dap")

			require("mason-nvim-dap").setup({
				ensure_installed = { "python", "cppdbg", "java-debug-adapter" }, -- debuggers
				handlers = {
					function(config)
						-- default handler hoe can i specify this for all as a comman i think i should
						require("mason-nvim-dap").default_setup(config)
					end,
					python = function(config)
						config.adapters = {
							type = "executable",
							command = "/usr/bin/python3",
							args = { "-m", "debugpy.adapter" },
						}
						require("mason-nvim-dap").default_setup(config)
					end,
					cppdbg = function(config)
						require("mason-nvim-dap").default_setup(config)
					end,
				},
			})

			dap.configurations.java = {
				{
					name = "Debug Current Java File",
					type = "java-debug-adapter",
					request = "launch",
					mainClass = function()
						local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
						local package = ""
						local class = vim.fn.expand("%:t:r")
						for _, line in ipairs(lines) do
							local p = line:match("^%s*package%s+([%w%.]+);")
							if p then
								package = p
								break
							end
						end
						return package ~= "" and package .. "." .. class or class
					end,
					classPaths = { "${workspaceFolder}/bin" }, -- Your compiled classes dir
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					console = "integratedTerminal",
					preLaunchTask = "javac -d bin ${fileDirname}/*.java", -- Optional auto-compile
				},
			}
			-- dap.configurations.java = {
			-- 					name="debuggJ",
			-- 					type="java-debug-adapter",
			-- 					request="launch",
			-- 					program="for running path here ",
			-- 					cwd="the debug code place ",
			-- 					stopAtEntry=false,
			-- 					args='idk what to use here why do i want this ',
			-- 					setupCommands="a list of cmds to execute before debuging starts ",
			--
			-- 			}
			-- -- C/C++ Debug configurations
			dap.configurations.c = {
				{
					name = "Launch C Program",
					type = "cppdbg",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopAtEntry = false,
					setupCommands = {
						{
							text = "-enable-pretty-printing",
							description = "enable pretty printing",
							ignoreFailures = false,
						},
					},
				},
				{
					name = "Attach to gdb",
					type = "cppdbg",
					request = "attach",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					processId = function()
						return tonumber(vim.fn.input("Process ID: "))
					end,
					cwd = "${workspaceFolder}",
					setupCommands = {
						{
							text = "-enable-pretty-printing",
							description = "enable pretty printing",
							ignoreFailures = false,
						},
					},
				},
			}

			-- Also set same configurations for cpp
			dap.configurations.cpp = dap.configurations.c
			-- dap.configurations.java-debug-adapter={
			-- 						name="debug the java program",
			--
			-- 				}
			-- Keymaps for debugging
			vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
			vim.keymap.set("n", "<F1>", dap.step_into, { desc = "Debug: Step Into" })
			vim.keymap.set("n", "<F2>", dap.step_over, { desc = "Debug: Step Over" })
			vim.keymap.set("n", "<F3>", dap.step_out, { desc = "Debug: Step Out" })
			vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
			vim.keymap.set("n", "<leader>B", function()
				dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end, { desc = "Debug: Set Conditional Breakpoint" })
			vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Debug: Open REPL" })
			vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "Debug: Run Last" })
		end,
	},

	-- DAP Virtual Text
	{
		"theHamsta/nvim-dap-virtual-text",
		dependencies = { "mfussenegger/nvim-dap" },
		config = function()
			require("nvim-dap-virtual-text").setup({
				enabled = true,
				enabled_commands = true,
				highlight_changed_variables = true,
				highlight_new_as_changed = false,
				show_stop_reason = true,
				commented = false,
				only_first_definition = true,
				all_references = false,
				filter_references_pattern = "<module",
				virt_text_pos = "eol",
				all_frames = false,
				virt_lines = false,
				virt_text_win_col = nil,
			})
		end,
	},
}
