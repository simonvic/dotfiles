return function()
	local dapui = require("dapui")
	dapui.setup({
		icons = { expanded = "", collapsed = "▶", current_frame = "" },
		layouts = {
			{
				elements = {
					-- Elements can be strings or table with id and size keys.
					"scopes",
					"breakpoints",
					"stacks",
					"watches",
				},
				size = 40, -- 40 columns
				position = "right",
			},
			{
				elements = {
					"repl",
					"console",
				},
				size = 0.25, -- 25% of total lines
				position = "bottom",
			},
		},
	})

	require("dap").listeners.after.event_initialized["dapui_config"] = function()
		dapui.open()
	end
end
