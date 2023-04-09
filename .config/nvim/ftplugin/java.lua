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

local cmd = { "/usr/bin/jdtls" }
local lombokJar = vim.fn.glob("~/.m2/repository/org/projectlombok/lombok/*/lombok-*[0-9].jar", 1)
local debugJar = vim.fn.glob("~/.m2/repository/com/microsoft/java/com.microsoft.java.debug.plugin/*/*.jar", 1)
local testJars = vim.fn.glob("~/.vscode-oss/extensions/vscjava.vscode-java-test-*/server/*.jar", 1)

if vim.fn.empty(lombokJar) == 0 then
	vim.list_extend(cmd, { "--jvm-arg=-javaagent:" .. lombokJar })
end

local bundles = { debugJar }
vim.list_extend(bundles, vim.split(testJars, "\n"))

jdtls.start_or_attach({
	cmd = cmd,
	root_dir = require("jdtls.setup").find_root({ ".gradlew", ".git", "mvnw", "pom.xml" }),
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
			codeGeneration = {
				generateComments = true
			},
			implementationCodeLens = { enabled = false },
			referencesCodeLens = { enabled = false },
			inlayhints = {
				parameterNames = {
					enabled = true
				}
			},
			format = {
				settings = {
					url = "~/.config/jdtls/settings.xml"
				},
				comments = { enabled = false },
			},
			sources = {
				organizeImports = {
					starThreshold = 5,
					staticStarThreshold = 3
				}
			}
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
