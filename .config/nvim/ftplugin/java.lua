local vim = vim

vim.opt.colorcolumn = "100";

local jdtls = require("jdtls")
vim.api.nvim_create_user_command(
	"JTestClass",
	function(input)
		jdtls.test_class()
	end,
	{}
)
vim.api.nvim_create_user_command(
	"JTestMethod",
	function(input)
		jdtls.test_nearest_method()
	end,
	{}
)

local bundles = {
	vim.fn.glob("~/.m2/repository/com/microsoft/java/com.microsoft.java.debug.plugin/*/com.microsoft.java.debug.plugin-*.jar"
		, 1)
}

vim.list_extend(bundles,
	vim.split(vim.fn.glob("~/.vscode-oss/extensions/vscjava.vscode-java-test-*/server/*.jar", 1), "\n"))

jdtls.start_or_attach({
	cmd = { "/usr/bin/jdtls" },
	root_dir = vim.fs.dirname(vim.fs.find({ ".gradlew", ".git", "mvnw", "pom.xml" }, { upward = true })[1]),
	init_options = {
		bundles = bundles
	},
	capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
	on_attach = function(client, bufnr)
		require("jdtls").setup_dap({ hotcode_replace = "auto" })
		require("jdtls.setup").add_commands()
		vim.keymap.set({ "n", "i" }, "<A-i>", function() require("jdtls").organize_imports() end)
	end,
	settings = {
		java = {
			format = {
				settings = {
					url = "~/.config/jdtls/settings.xml"
				}
			},
			-- configuration = {
			-- 	runtimes = {
			-- 		{
			-- 			name = "JavaSE-11",
			-- 			path = "/usr/lib/jvm/java-11-openjdk/",
			-- 		},
			-- 		{
			-- 			name = "JavaSE-17",
			-- 			path = "/usr/lib/jvm/java-17-openjdk/",
			-- 		},
			-- 		{
			-- 			name = "JavaSE-19",
			-- 			path = "/usr/lib/jvm/java-19-openjdk/",
			-- 		},
			-- 	}
			-- }
		}
	}
})
