return {
	{
		"mason-org/mason.nvim",
		config = function()
			require("mason").setup()
		end,
		opts = { ensure_installed = { "java-debug-adapter", "java-test" } },
	},

	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "clangd" }, -- Specify desired LSP servers
				handlers = {
					--[[ for default capabilities ]]
					function(server_name)
						require("lspconfig")[server_name].setup({})
					end,

					["lua_ls"] = function()
						local lspconfig = require("lspconfig")
						lspconfig.lua_ls.setup({
							capabilities = require("cmp_nvim_lsp").default_capabilities(),
							settings = {
								Lua = {
									diagnostics = {
										globals = { "vim" },
									},
								},
							},
							root_dir = lspconfig.util.root_pattern(".git", ".luarc.json", "init.lua") or vim.loop.cwd(),
						})
					end,
					["clangd"] = function()
						local lspconfig = require("lspconfig")
						lspconfig.clangd.setup({
							capabilities = require("cmp_nvim_lsp").default_capabilities(),
							cmd = {
								"clangd",
								"--background-index",
								"--clang-tidy",
								"--header-insertion=iwyu",
								"--completion-style=detailed",
								"--function-arg-placeholders",
								"--fallback-style=llvm",
							},
							root_dir = lspconfig.util.root_pattern(
								"compile_commands.json",
								"compile_flags.txt",
								".clangd",
								"CMakeLists.txt",
								"Makefile",
								".git"
							) or vim.loop.cwd(),
							filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
							single_file_support = true,
						})
					end,
					["jdtls"] = function()
						local lspconfig = require("lspconfig")
						lspconfig.jdtls.setup({
							capabilities = require("cmp_nvim_lsp").default_capabilities(),
							on_attach = function(client, bufnr)
								vim.keymap.set(
									"n",
									"<leader>ca",
									vim.lsp.buf.code_action,
									{ buffer = bufnr, desc = "LSP: Code action" }
								)
								vim.keymap.set(
									"n",
									"K",
									vim.lsp.buf.hover,
									{ buffer = bufnr, desc = "LSP: Show hover documentation" }
								)
								vim.keymap.set(
									"n",
									"gd",
									vim.lsp.buf.definition,
									{ buffer = bufnr, desc = "LSP: Go to definition" }
								)
								vim.keymap.set(
									"n",
									"gr",
									vim.lsp.buf.references,
									{ buffer = bufnr, desc = "LSP: Find references" }
								)
								vim.keymap.set(
									"n",
									"<leader>rn",
									vim.lsp.buf.rename,
									{ buffer = bufnr, desc = "LSP: Rename symbol" }
								)
								require("dap").configurations.java = {
									{
										type = "java",
										request = "launch",
										name = "Launch Java Program",
										mainClass = "", -- Set this dynamically or via project config
										projectName = "hello", -- Adjust based on your project
									},
								}
							end,
							root_dir = lspconfig.util.root_pattern("pom.xml", "build.gradle", ".git") or vim.loop.cwd(),
							cmd = { "jdtls", "-data", vim.fn.expand("~/.cache/jdtls/workspace") },
							settings = {
								java = {
									configuration = {
										runtimes = {
											{ name = "JavaSE-17", path = "/path/to/your/jdk" },
										},
									},
								},
							},
						})
					end,
				},
			})
			vim.keymap.set("n", "k", vim.lsp.buf.hover, {})

			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			--for
			vim.keymap.set({ "n" }, "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
	-- {
	-- 	"neovim/nvim-lspconfig",
	-- 	opts = {
	-- 		-- make sure mason installs the server
	-- 		servers = {
	-- 			jdtls = {},
	-- 		},
	-- 		setup = {
	-- 			jdtls = function()
	-- 				return true -- avoid duplicate servers
	-- 			end,
	-- 		},
	-- 	},
	-- },
	-- Diagnostic configuration
	vim.diagnostic.config({
		virtual_text = {
			prefix = "●",
			source = "always",
			spacing = 4,
			format = function(diagnostic)
				return string.format("%s: %s", diagnostic.source, diagnostic.message)
			end,
		},
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = "✖",
				[vim.diagnostic.severity.WARN] = "⚠",
				[vim.diagnostic.severity.INFO] = "➤",
				[vim.diagnostic.severity.HINT] = "ℹ",
			},
		},
		underline = true,
		severity_sort = true,
		update_in_insert = false,
	}),
}
