return function()
	require("window-picker").setup({
		hint = "floating-big-letter",
		filter_rules = {
			bo = {
				filetype = {
					"NvimTree",
					"neo-tree",
					"notify",
					"lazy",
					"qf",
					"diff",
					"aerial",
					"dap-repl",
					"dapui_breakpoints",
					"dapui_console",
					"dapui_stacks",
					"dapui_scopes",
					"dapui_watches",
				},
				buftype = { "terminal" },
			},
		}
	})
end
