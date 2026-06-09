return function()
	local glyphs = require("simonvic.glyphs")
	local ccc = require("ccc")
	local mapping = ccc.mapping
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
		mappings = {
			-- TODO: move to keybindings
			["L"] = mapping.increase10,
			["H"] = mapping.decrease10,
			["0"] = mapping.set0,
			["$"] = mapping.set100,
		}
	})
	require("simonvic.keybindings").implement({
		color_picker = function() vim.cmd("CccPick") end
	})
end
