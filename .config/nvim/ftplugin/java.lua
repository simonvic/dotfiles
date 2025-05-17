vim.opt.colorcolumn = "100"
vim.opt.textwidth = 100

local ok, jdtls = pcall(require, "jdtls");
if not ok then
	vim.notify("nvim-jdtls plugin not installed. Raw-dogging jdtls")
	vim.lsp.enable("jdtls")
	return
end

local lsp_config = vim.lsp.config.jdtls
local cmd = lsp_config.cmd

-- Lombok support
local jars_lombok = vim.fn.glob("~/.m2/repository/org/projectlombok/lombok/*/lombok-*[0-9].jar", true)
if vim.fn.empty(jars_lombok) == 0 then
	jars_lombok = vim.split(jars_lombok, "\n")
	-- TODO: is it safe to assume cmd is string[] ?
	---@diagnostic disable-next-line: param-type-mismatch
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
	root_dir = vim.fs.root(0, lsp_config.root_markers),
	init_options = { bundles = bundles },
	settings = lsp_config.settings,
	capabilities = lsp_config.capabilities,
	on_attach = function(client, bufnr)
		jdtls.setup_dap({ hotcode_replace = "auto" })
		local keybindings = require("simonvic.keybindings")
		keybindings.set(keybindings.plugins.jdtls) -- TODO: set with opt bufnr
	end
}

-- Custom pick_many and pick_one implementations
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
			local qf = vim.fn.getqflist()
			local qf_text = {}
			for i, qf_entry in pairs(qf) do
				-- Remove prefix digits added by snacks
				local text, _ = string.gsub(qf_entry.text, "[0-9]+ ", "")
				table.insert(qf_text, text)
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

local pick_one = function(items, prompt, label_fn)
	local co = coroutine.running();
	local choices = {}
	for i, item in pairs(items) do
		table.insert(choices, label_fn(item))
	end
	vim.ui.select(choices, { prompt = prompt },
		function(choice, index)
			if index == nil then
				coroutine.resume(co, nil) -- Just to be explicit
			else
				coroutine.resume(co, items[index])
			end
		end
	)
	return coroutine.yield()
end

require("jdtls.ui").pick_many = pick_many
require("jdtls.ui").pick_one = pick_one

jdtls.start_or_attach(jdtls_config)
