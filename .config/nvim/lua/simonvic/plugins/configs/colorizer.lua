return function()
	require("colorizer").setup({
		options = {
			parsers = {
				css_fn = true,
				names = {
					enable = false
				},
				hex = {
					default = true,
					rgb = false,
					rgba = false,
					rrggbbaa = true,
					aarrggbb = true,
				}
			},
			display = {
				mode = "virtualtext",
				virtualtext = {
					char = require("simonvic.glyphs").ui.color_pill,
					position = "eol",
					hl_mode = "foreground",
				}
			},
		}
	})
end
