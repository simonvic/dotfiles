return {
	name = "giovils_proxy",
	-- root_markers = { ".git" },
	cmd = {
		"java",
		"-jar",
		"/home/simonvic/Documents/Productivity/Programming/JAVA/Giovi/target/Giovi.jar",
		"--ls-proxy"
	},
	filetypes = { "giovi" },
	settings = {},
}
