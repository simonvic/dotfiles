return function()
	local mason_lspconfig = require("mason-lspconfig")
	mason_lspconfig.setup()

	local default_capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

	mason_lspconfig.setup_handlers({
		function(server_name)
			require("lspconfig")[server_name].setup({ capabilities = default_capabilities })
		end,
	})
end
