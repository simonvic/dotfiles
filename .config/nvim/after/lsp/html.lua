---@type vim.lsp.Config
return {
	---@type lspconfig.settings.html
	settings = {
		html = {
			format = {
				indentInnerHtml = false,
				contentUnformatted = "pre,code,textarea",
				wrapAttributes = "preserve",
			}
		}
	}
}
