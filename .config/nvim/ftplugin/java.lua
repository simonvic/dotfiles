require("jdtls").start_or_attach({
	cmd = { "/usr/bin/jdtls" },
	root_dir = vim.fs.dirname(vim.fs.find({ ".gradlew", ".git", "mvnw" }, { upward = true })[1]),
	init_options = {
		bundles = {
			vim.fn.glob("~/.m2/repository/com/microsoft/java/com.microsoft.java.debug.plugin/0.42.0/com.microsoft.java.debug.plugin-0.42.0.jar"
				, 1)
		}
	},
	capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
	on_attach = function(client, bufnr)
		require("jdtls").setup_dap({ hotcode_replace = "auto" })
		require("jdtls.setup").add_commands()
	end
})
