return {
	"mfussenegger/nvim-jdtls",
	ft = { "java" }, -- load only for Java files
	config = function()
		local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
		-- can i cange the workspace dynamically
		local workspace_dir = "/home/darkemperor/aathi/LEET/JAVA/" .. project_name
		local bundles = {
			vim.fn.glob("/home/darkemperor/.local/share/java-debug/com.microsoft.java.debug.plugin-*.jar", 1),
			vim.fn.glob("/home/darkemperor/.local/share/vscode-java-test/server/*.jar", 1),
		}
		local config = {
			cmd = {
				-- can i make this valid for multiple jdk version and i need to learn how this works fr the future works
				"/usr/lib/jvm/java-21-openjdk-amd64/bin/java",

				"-Declipse.application=org.eclipse.jdt.ls.core.id1",
				"-Dosgi.bundles.defaultStartLevel=4",
				"-Declipse.product=org.eclipse.jdt.ls.core.product",
				"-Dlog.protocol=true",
				"-Dlog.level=ALL",
				"-Xmx1g",
				"--add-modules=ALL-SYSTEM",
				"--add-opens",
				"java.base/java.util=ALL-UNNAMED",
				"--add-opens",
				"java.base/java.lang=ALL-UNNAMED",

				"-jar",
				"/home/darkemperor/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.7.0.v20250519-0528.jar",
				"-configuration",
				"/home/darkemperor/.local/share/nvim/mason/packages/jdtls/config_linux",

				"-data",
				workspace_dir,
			},

			root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew" }),

			settings = {
				java = {},
			},

			init_options = {
				bundles = {},
			},
		}

		require("jdtls").start_or_attach(config)
	end,
}
