---@type vim.lsp.Config
return {
	name = "giovils",
	-- root_markers = { ".git" },
	cmd = {
		"java",
		"-jar",
		"/home/simonvic/Documents/Productivity/Programming/JAVA/Giovi/target/Giovi.jar",
		"--ls"
	},
	filetypes = { "giovi" },
	settings = {},
}
