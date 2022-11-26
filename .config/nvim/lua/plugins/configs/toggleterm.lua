return function()
	require("toggleterm").setup({
		size = 10,
		shading_factor = 2,
		direction = "horizontal",
		highlights = {
			Normal = { link = "Normal" }
		},
		float_opts = {
			border = "curved",
			highlights = {
				border = "Normal",
				background = "Normal",
			}
		},
		winbar = {
			enabled = true,
			name_formatter = function(term)
				return term.name
			end
		},
	})
end
