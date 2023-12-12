local vim = vim

vim.opt.colorcolumn = "100";

local jdtls = require("jdtls")

local cmd = { "/usr/bin/jdtls" }
local jars_lombok = vim.fn.glob("~/.m2/repository/org/projectlombok/lombok/*/lombok-*[0-9].jar", 1)
local jars_debug = vim.fn.glob("~/.m2/repository/com/microsoft/java/com.microsoft.java.debug.plugin/*/*.jar", 1)
local jars_testing = vim.fn.glob("~/.vscode-oss/extensions/vscjava.vscode-java-test-*/server/*.jar", 1)

if vim.fn.empty(jars_lombok) == 0 then
	vim.list_extend(cmd, { "--jvm-arg=-javaagent:" .. jars_lombok })
end

local bundles = { jars_debug }
vim.list_extend(bundles, vim.split(jars_testing, "\n"))
jdtls.start_or_attach({
	cmd = cmd,
	root_dir = require("jdtls.setup").find_root({ ".gradlew", ".git", "mvnw", "pom.xml" }),
	init_options = {
		bundles = bundles
	},
	capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
	on_attach = function(client, bufnr)
		jdtls.setup_dap({ hotcode_replace = "auto" })
		jdtls.setup.add_commands()
		local keybindings = require("simonvic.keybindings")
		keybindings.set(keybindings.plugins.jdtls)
	end,
	settings = {
		java = {
			configuration = {
				runtimes = {
					{
						name = "JavaSE-21",
						path = "/usr/lib/jvm/java-21-openjdk/",
					},
				},
			},
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
		}
	}
})
