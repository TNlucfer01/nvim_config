-- ftplugin/java.lua
local jdtls = require("jdtls")
local mason_path = vim.fn.stdpath("data") .. "/mason/packages/java-debug-adapter"

-- Locate the Java debug adapter jar installed by Mason
local bundles = {
	vim.fn.glob(mason_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar", 1),
}

-- Configure the Java LSP
local config = {
	cmd = {
		"/usr/lib/jvm/java-21-openjdk-amd64/bin/java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xms1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-jar",
		vim.fn.glob(vim.fn.stdpath("data") .. "/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar", 1),
		"-configuration",
		vim.fn.stdpath("data") .. "/mason/packages/jdtls/config_linux",
		"-data",
		vim.fn.getcwd(),
	},
	root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),
	init_options = {
		bundles = bundles,
	},
}

-- Start or attach JDTLS
jdtls.start_or_attach(config)

-- Set up DAP only after JDTLS is attached
vim.api.nvim_create_autocmd("LspAttach", {
	pattern = "*.java",
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client and client.name == "jdtls" then
			-- Enable hot code replace for Java debugging
			local jdtls_dap = require("jdtls.dap")
			require("jdtls").setup_dap({ hotcodereplace = "auto" })
			jdtls_dap.setup_dap_main_class_configs()
		end
	end,
})

-- Optional: keymaps for debugging
vim.keymap.set("n", "<F5>", function()
	require("dap").continue()
end)
vim.keymap.set("n", "<F9>", function()
	require("dap").toggle_breakpoint()
end)
vim.keymap.set("n", "<F10>", function()
	require("dap").step_over()
end)
vim.keymap.set("n", "<F11>", function()
	require("dap").step_into()
end)
vim.keymap.set("n", "<F12>", function()
	require("dap").step_out()
end)
