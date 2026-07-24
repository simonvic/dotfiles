return function()
	local glyphs = require("simonvic.glyphs")
	local ccc = require("ccc")
	ccc.setup({
		bar_len = 64,
		alpha_show = "hide",
		highlighter = {
			-- nvim-colorizer is less buggy and more performant
			auto_enable = false,
		},
		highlight_mode = "virtual",
		virtual_symbol = glyphs.ui.color_pill,
		virtual_pos = "eol",
		mappings = require("simonvic.keybindings").plugins.ccc()
	})
	require("simonvic.keybindings").implement({
		color_picker = function() vim.cmd("CccPick") end
	})
end
