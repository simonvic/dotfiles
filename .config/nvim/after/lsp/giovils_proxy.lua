---@type vim.lsp.Config
return {
	name = "giovils_proxy",
	-- root_markers = { ".git" },
	cmd = {
		"java",
		"-jar",
		"/home/simonvic/Documents/Productivity/Programming/JAVA/GioviLS/target/GioviLS.jar",
		"--proxy"
	},
	filetypes = { "giovi" },
	settings = {},
}
