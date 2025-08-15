return function()
	require("scrollbar").setup({
		set_highlights = false,
		handlers = {
			cursor = false
		},
		excluded_buftypes = {}
	})
end
