local vim = vim

vim.opt.colorcolumn = "100";

local jdtls = require("jdtls")
local cmd = { "/usr/bin/jdtls" }

-- Lombok support
local jars_lombok = vim.fn.glob("~/.m2/repository/org/projectlombok/lombok/*/lombok-*[0-9].jar", 1)
if vim.fn.empty(jars_lombok) == 0 then
	jars_lombok = vim.split(jars_lombok, "\n")
	vim.list_extend(cmd, { "--jvm-arg=-javaagent:" .. jars_lombok[#jars_lombok] })
end

local mason_path = vim.fn.stdpath("data") .. "/mason/packages"
local bundles = {}

-- Debug support
-- for upstream version: https://github.com/microsoft/java-debug
-- and glob "~/.m2/repository/com/microsoft/java/com.microsoft.java.debug.plugin/*/*.jar"
local jars_debug = vim.fn.glob(mason_path .. "/java-debug-adapter/extension/server/*.jar", 1)
if vim.fn.empty(jars_debug) == 0 then
	vim.list_extend(bundles, vim.split(jars_debug, "\n"))
end

-- Testing support
-- for upstream version: https://github.com/microsoft/vscode-java-test
-- and glob "~/.vscode-oss/extensions/vscjava.vscode-java-test-*/server/*.jar"
local jars_testing = vim.fn.glob(mason_path .. "/java-test/extension/server/*.jar", 1)
if vim.fn.empty(jars_testing) == 0 then
	vim.list_extend(bundles, vim.split(jars_testing, "\n"))
end

local jdtls_config = {
	cmd = cmd,
	root_dir = require("jdtls.setup").find_root({ ".gradlew", ".git", "mvnw", "pom.xml" }),
	init_options = {
		bundles = bundles
	},
	capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
	on_attach = function(client, bufnr)
		jdtls.setup_dap({ hotcode_replace = "auto" })
		local keybindings = require("simonvic.keybindings")
		keybindings.set(keybindings.plugins.jdtls)
	end,
	settings = {
		java = {
			codeGeneration = {
				generateComments = true
			},
			implementationCodeLens = { enabled = false },
			referencesCodeLens = { enabled = false },
			inlayHints = {
				parameterNames = {
					enabled = "all",
				},
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
}


local pick_many = function(items, prompt, label_f, opts)
	if not items or #items == 0 then
		return {}
	end

	local choices = {}
	for i, item in pairs(items) do
		table.insert(choices, label_f(item))
	end

	local co = coroutine.running()
	vim.ui.select(choices, { prompt = prompt, },
		function(choice, index)
			vim.notify("accepted")
			local qf = vim.fn.getqflist()
			local qf_text = {}
			for i, qf_entry in pairs(qf) do
				table.insert(qf_text, qf_entry.text)
			end
			local selected_items = {}
			for i, item in pairs(items) do
				if vim.list_contains(qf_text, label_f(item)) then
					table.insert(selected_items, item)
				end
			end
			coroutine.resume(co, selected_items)
		end
	)
	return coroutine.yield()
end

require("jdtls.ui").pick_many = pick_many

jdtls.start_or_attach(jdtls_config)
