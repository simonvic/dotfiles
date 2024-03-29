return function()
	local c = require("simonvic.colorscheme").groups
	require("scrollbar").setup({
		handle = {
			color = c.ScrollbarHandle.bg
		},
		marks = {
			Search = { color = c.ScrollbarSearchHandle.fg },
			Error  = { color = c.ScrollbarErrorHandle.fg },
			Warn   = { color = c.ScrollbarWarnHandle.fg },
			Info   = { color = c.ScrollbarInfoHandle.fg },
			Hint   = { color = c.ScrollbarHintHandle.fg },
			Misc   = { color = c.ScrollbarMiscHandle.fg },
		},
		handlers = {
			cursor = false
		}
	})
end
