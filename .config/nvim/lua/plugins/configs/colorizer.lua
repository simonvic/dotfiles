return function()
	require("colorizer").setup({
		filetype = {"*"},
		user_default_options = {
			names = false,
			RRGGBBAA = true,
			AARRGGBB = true,
			css = false,
			css_fn = true,
			mode = "background"
		}
	})
end
