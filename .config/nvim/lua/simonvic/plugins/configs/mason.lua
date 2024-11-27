return function()
	require("mason").setup({
		ui = {
			border = "rounded",
			icons = require("simonvic.glyphs").plugins.mason,
		}
	})
end
