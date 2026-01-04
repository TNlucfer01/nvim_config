local map = vim.keymap.set

map("n", "<leader>l", function()
	require("lint").try_lint()
end, { desc = "Trigger linting" })

map("n", "<leader>hf", function()
	require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format buffer" })

return {

	{
		"stevearc/conform.nvim",

		dependencies = { "mason-org/mason.nvim" },
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					python = { "black" },
					javascript = { "prettier" },
					typescript = { "prettier" },
					java = { "google-java-format" },
					c = { "clang-format" },
					cpp = { "clang-format" },
					sh = { "shfmt" },
					bash = { "shfmt" },
				},

				format_on_save = {
					timeout_ms = 500,
					lsp_fallback = true,
				},
				default_format_opts = {
					lsp_format = "fallback",
				},
			})
		end,
	},
	{
		"mfussenegger/nvim-lint",
		dependencies = { "mason-org/mason.nvim" },
		config = function()
			local lint = require("lint")
			lint.linters_by_ft = {
				lua = { "selene" },
				python = { "pylint", "flake8" },
				javascript = { "eslint_d" },
				typescript = { "eslint_d" },
			}
			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function()
					lint.try_lint()
				end,
			})
			vim.keymap.set("n", "<leader>l", function()
				lint.try_lint()
			end, { desc = "Trigger linting" })
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "mason-org/mason.nvim" },
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					"stylua",
					"selene",
					"black",
					"prettier",
					"pylint",
					"flake8",
					"eslint_d",
					-- C/C++ tools
					"clangd",
					"cppdbg",
					"clang-format",
					"google-java-format",
					"shfmt",
				},
				auto_update = true, -- Automatically update tools when running :MasonUpdate
			})
		end,
	},
}
