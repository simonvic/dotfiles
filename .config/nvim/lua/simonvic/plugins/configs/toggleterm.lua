return function()
	require("toggleterm").setup({
		size = 10,
		shading_factor = 2,
		direction = "horizontal",
		highlights = {
			WinBar = { link = "WinBar" }
		},
		float_opts = {
			border = "curved",
		},
	})
end
