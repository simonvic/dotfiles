local vim = vim

vim.opt.colorcolumn = "100";

local jdtls = require("jdtls")

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
		jdtls.setup_dap({ hotcode_replace = "auto" })
		jdtls.setup.add_commands()
		vim.keymap.set({ "n", "i" }, "<A-i>", function() jdtls.organize_imports() end)
		vim.keymap.set({ "n", "i" }, "<F6>", function() jdtls.pick_test() end)          -- F6
		vim.keymap.set({ "n", "i" }, "<F18>", function() jdtls.test_class() end)        -- Shift + F6
		vim.keymap.set({ "n", "i" }, "<F30>", function() jdtls.test_nearest_method() end) -- Ctrl + F6
		vim.keymap.set({ "n", "i" }, "<F19>", function() vim.cmd("JdtUpdateDebugConfig") end) -- Shift + F7
		vim.keymap.set({ "n", "i" }, "<F31>", function() vim.cmd("JdtUpdateHotcode") end) -- Ctrl + F7
		vim.keymap.set({ "n", "i" }, "<C-A-b>", function() jdtls.super_implementation() end)
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
		}
	}
})
