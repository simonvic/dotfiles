return function()
	local glyphs = require("simonvic.glyphs")
	local keybindings = require("simonvic.keybindings")
	local dap = require("dap")
	local dapui = require("dapui")
	---@diagnostic disable-next-line: missing-fields
	dapui.setup({
		floating = {
			border = vim.o.winborder
		},
		mappings = keybindings.plugins.dapui,
		icons = {
			expanded = glyphs.ui.expanded,
			collapsed = glyphs.ui.collapsed,
			current_frame = glyphs.dap.current_frame,
		},
		controls = {
			enabled = true,
			icons = glyphs.dap.controls.icons
		},
		layouts = {
			{
				position = "right",
				size = 16,
				elements = {
					{ id = "stacks",  size = 0.20, },
					{ id = "watches", size = 0.20, },
					{ id = "scopes",  size = 0.60, },
				},
			},
			{
				position = "bottom",
				size = 8,
				elements = {
					{ id = "breakpoints", size = 0.10 },
					{ id = "console",     size = 0.50 },
					{ id = "repl",        size = 0.40 },
				},
			},
		},
	})

	dap.listeners.after.event_initialized["dapui_config"] = function()
		dapui.open()
	end

	keybindings.implement({
		toggle_debugger = dapui.toggle,
		inspect_variable = dapui.eval,
	})
end
