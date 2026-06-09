---@type vim.lsp.Config
return {
	filetypes = { "tex" },
	---@type lspconfig.settings.ltex
	settings = {
		ltex = {
			language = "auto",
		}
	}
}
