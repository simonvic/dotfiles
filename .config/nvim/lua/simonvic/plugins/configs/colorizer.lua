return function()
	require("colorizer").setup({
		options = {
			parsers = {
				css_fn = true,
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
					char = require("simonvic.glyphs").plugins.colorizer.virtualtext,
					position = "eol",
					hl_mode = "foreground",
				}
			},
		}
	})
end
