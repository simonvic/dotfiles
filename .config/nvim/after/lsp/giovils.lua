---@type vim.lsp.Config
return {
	name = "giovils",
	-- root_markers = { ".git" },
	cmd = {
		"java",
		"-jar",
		"/home/simonvic/Documents/Productivity/Programming/JAVA/GioviLS/target/GioviLS.jar"
	},
	filetypes = { "giovi" },
	settings = {},
}
