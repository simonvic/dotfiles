return function()
	require("colorizer").setup({
		filetype = { "*" },
		user_default_options = {
			names    = false,
			RRGGBB   = true,
			RRGGBBAA = true,
			AARRGGBB = true,
			css      = false,
			css_fn   = true,
			mode     = "virtualtext",
			virtualtext = require("simonvic.signs").plugins.colorizer.virtualtext,
		}
	})
end
