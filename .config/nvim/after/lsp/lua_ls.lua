return {
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" }, },
			workspace = { library = vim.api.nvim_get_runtime_file("", true), },
			telemetry = { enable = false, },
		}
	}
}
