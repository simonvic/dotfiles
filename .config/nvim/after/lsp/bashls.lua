---@type vim.lsp.Config
return {
	---@type lspconfig.settings.bashls
	settings = {
		bashIde = {
			enableSourceErrorDiagnostics = true,
			shfmt = {
				binaryNextLine = true,
				caseIndent = true,
				spaceRedirects = true,
			}
		}
	}
}
