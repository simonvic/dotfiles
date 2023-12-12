return function()
	local mason_lspconfig = require("mason-lspconfig")
	mason_lspconfig.setup()

	local default_capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

	mason_lspconfig.setup_handlers({
		function(server_name)
			require("lspconfig")[server_name].setup({ capabilities = default_capabilities })
		end,
		["rust_analyzer"] = function(_)
			local rt = require("rust-tools")
			rt.setup({
				tools = {
					inlay_hints = {
						parameter_hints_prefix = "",
						other_hints_prefix = "",
					}
				}
			})
			-- rt.setup({
			-- 	server = {
			-- 		-- capabilities = default_capabilities,
			-- 		on_attach = function(_, bufnr)
			-- 			vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
			-- 		end,
			-- 	},
			-- 	-- dap = {
			-- 	-- 	-- adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)
			-- 	-- 	adapter = {
			-- 	-- 		type = "executable",
			-- 	-- 		command = "lldb-vscode",
			-- 	-- 		name = "rt_lldb",
			-- 	-- 	},
			-- 	-- },
			-- })
		end
	})
end
