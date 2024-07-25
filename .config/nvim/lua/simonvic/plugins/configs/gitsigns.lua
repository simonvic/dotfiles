return function()
	require('gitsigns').setup({
		preview_config = {
			border = "rounded",
		},
		signs = require("simonvic.signs").plugins.gitsigns,
	})
end
