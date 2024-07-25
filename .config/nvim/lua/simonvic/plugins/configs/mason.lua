return function()
	require("mason").setup({
		ui = {
			border = "rounded",
			icons = require("simonvic.signs").plugins.mason,
		}
	})
end
