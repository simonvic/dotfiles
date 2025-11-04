vim.opt.colorcolumn = "100"
vim.opt.textwidth = 100

local ok, jdtls = pcall(require, "jdtls");
if not ok then
	if not vim.lsp.is_enabled("jdtls") then
		vim.notify("nvim-jdtls plugin not installed. Raw-dogging jdtls")
		vim.lsp.enable("jdtls")
	end
	return
end

local lsp_config = vim.lsp.config.jdtls
-- TODO: is it safe to assume cmd is string[] ?
---@type string[]
---@diagnostic disable-next-line: assign-type-mismatch
local cmd = lsp_config.cmd

-- Setup project root directory
local root_dir = vim.fs.root(0, lsp_config.root_markers)

-- Setup workspace data directory
-- TODO: should not be needed anymore since jdtls 1.51.0
local project_name = vim.fn.fnamemodify(root_dir or "unknown", ":t")
vim.list_extend(cmd, {
	"-data", vim.fn.expand("~/.cache/jdtls/workspaces/") .. project_name
})

-- Lombok support
local jars_lombok = vim.fn.glob("~/.m2/repository/org/projectlombok/lombok/*/lombok-*[0-9].jar", true)
if vim.fn.empty(jars_lombok) == 0 then
	jars_lombok = vim.split(jars_lombok, "\n")
	vim.list_extend(cmd, { "--jvm-arg=-javaagent:" .. jars_lombok[#jars_lombok] })
end

local mason_packages = vim.fn.expand("$MASON") .. "/packages"
local bundles = {}

-- Debug support
local jars_debug = vim.fn.glob(mason_packages .. "/java-debug-adapter/extension/server/*.jar", true)
if vim.fn.empty(jars_debug) == 0 then
	vim.list_extend(bundles, vim.split(jars_debug, "\n"))
end

-- Testing support
local jars_testing = vim.fn.glob(mason_packages .. "/java-test/extension/server/*.jar", true)
if vim.fn.empty(jars_testing) == 0 then
	vim.list_extend(bundles, vim.split(jars_testing, "\n"))
end

local jdtls_config = {
	cmd = cmd,
	root_dir = root_dir,
	init_options = { bundles = bundles },
	settings = lsp_config.settings,
	capabilities = lsp_config.capabilities,
	-- capabilities = vim.tbl_deep_extend("force", lsp_config.capabilities, {
	-- 	textDocument = {
	-- 		completion = {
	-- 			completionItem = {
	-- 				-- treesitter might have better syntax highlighting
	-- 				labelDetailsSupport = false
	-- 			}
	-- 		}
	-- 	}
	-- }),
	on_attach = function(client, bufnr)
		jdtls.setup_dap({ hotcode_replace = "auto" })
		local keybindings = require("simonvic.keybindings")
		keybindings.set(keybindings.plugins.jdtls)
	end
}

jdtls.start_or_attach(jdtls_config)
