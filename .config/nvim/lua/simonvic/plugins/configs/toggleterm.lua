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
	require("simonvic.keybindings").implement({
		terminal = function() vim.cmd("ToggleTerm direction=horizontal") end,
		terminal_float = function() vim.cmd("ToggleTerm direction=float") end
	})
end
