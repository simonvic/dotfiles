return function()
	local mason_lspconfig = require("mason-lspconfig")
	mason_lspconfig.setup()

	local default_capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

	mason_lspconfig.setup_handlers({

		-- Default handler
		function(server_name)
			require("lspconfig")[server_name].setup({ capabilities = default_capabilities })
		end,

		-- Per-language handlers

		["lua_ls"] = function(server_name)
			require("lspconfig")[server_name].setup({
				capabilities = default_capabilities,
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" }, },
						workspace = { library = vim.api.nvim_get_runtime_file("", true), },
						telemetry = { enable = false, },
					}
				}
			})
		end,

		["html"] = function(server_name)
			require("lspconfig").html.setup({
				capabilities = default_capabilities,
				settings = {
					html = {
						format = {
							indentInnerHtml = true,
							contentUnformatted = "pre,code,textarea"
						}
					}
				}
			})
		end

	})
end
