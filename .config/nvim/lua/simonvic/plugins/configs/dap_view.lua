return function()
	local dapview = require("dap-view")
	local glyphs = require("simonvic.glyphs")
	dapview.setup({
		auto_toggle = "keep_terminal",
		virtual_text = {
			enabled = true,
			position = "inline",
		},
		winbar = {
			controls = {
				enabled = true,
			},
			sections = {
				-- "console",
				"repl",
				"breakpoints",
				"scopes",
				"watches",
				"exceptions",
				"threads",
				"sessions",
			},
			default_section = "repl",
		},
		windows = {
			position = "below",
			size = 0.33,
			terminal = {
				position = "below",
				size = 0.25
			},
		},
		icons = {
			collapsed = glyphs.ui.collapsed .. " ",
			expanded = glyphs.ui.expanded .. " ",
			disabled = glyphs.ui.disabled,
			enabled = glyphs.ui.enabled,
			filter = glyphs.ui.filter,
			negate = " ",
			play = glyphs.dap.controls.play,
			pause = glyphs.dap.controls.pause,
			terminate = glyphs.dap.controls.stop,
			disconnect = glyphs.dap.controls.disconnect,
			run_last = glyphs.dap.controls.run_last,
			step_back = glyphs.dap.controls.step_back,
			step_into = glyphs.dap.controls.step_into,
			step_out = glyphs.dap.controls.step_out,
			step_over = glyphs.dap.controls.step_over,
		},
	})
	require("simonvic.keybindings").implement({
		toggle_debugger = function() dapview.toggle(true) end,
		inspect_variable = dapview.hover,
	})
end
