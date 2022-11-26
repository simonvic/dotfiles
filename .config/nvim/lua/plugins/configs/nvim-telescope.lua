return function()
	local telescopeActions = require("telescope.actions")
	require("telescope").setup({
		defaults = {
			mappings = {
				i = {
					["<esc>"] = telescopeActions.close,
					["<C-h>"] = telescopeActions.select_horizontal,
					["<C-v>"] = telescopeActions.select_vertical,
				}
			}
		},
	})
end
