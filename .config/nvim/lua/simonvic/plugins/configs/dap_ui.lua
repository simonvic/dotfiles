return function()
	local dapui = require("dapui")
	dapui.setup({
		mappings = require("simonvic.keybindings").plugins.dapui,
		icons = require("simonvic.signs").plugins.dapui,
		layouts = {
			{
				position = "bottom",
				size = 8,
				elements = {
					{ id = "breakpoints", size = 0.20 },
					{ id = "repl",        size = 0.30 },
					{ id = "console",     size = 0.50 }
				},
			},
			{
				position = "right",
				size = 16,
				elements = {
					{ id = "stacks",  size = 0.20, },
					{ id = "scopes",  size = 0.40, },
					{ id = "watches", size = 0.40, },
				},
			},
		},
	})

	require("dap").listeners.after.event_initialized["dapui_config"] = function()
		dapui.open()
	end
end
