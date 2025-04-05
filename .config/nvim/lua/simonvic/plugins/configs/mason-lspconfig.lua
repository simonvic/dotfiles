return function()
	local mason_lspconfig = require("mason-lspconfig")
	mason_lspconfig.setup()

	mason_lspconfig.setup_handlers({

		-- Default handler
		function(server_name)
			require("lspconfig")[server_name].setup({})
		end,

		-- Per-language handlers

		["lua_ls"] = function(server_name)
			require("lspconfig")[server_name].setup({
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
				settings = {
					html = {
						format = {
							indentInnerHtml = true,
							contentUnformatted = "pre,code,textarea"
						}
					}
				}
			})
		end,

		["ltex"] = function(server_name)
			require("lspconfig")[server_name].setup({
				filetypes = { "tex" },
			})
		end

	})
end
