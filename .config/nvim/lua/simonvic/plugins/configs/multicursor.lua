return function()
	local multicursor = require("multicursor-nvim")
	multicursor.setup({
		signs = false
	})
	require("simonvic.keybindings").implement({
		cursors_add_down       = function() multicursor.addCursor("j") end,
		cursors_add_up         = function() multicursor.addCursor("k") end,
		cursors_add_word       = function() multicursor.addCursor("*") end,
		cursors_add_selection  = function() multicursor.matchAddCursor(1) end,
		cursors_skip_selection = function() multicursor.matchSkipCursor(1) end,
		cursors_align          = multicursor.alignCursors,
		cursors_toggle         = function()
			if multicursor.cursorsEnabled() then
				multicursor.disableCursors()
			else
				multicursor.enableCursors()
			end
		end,
		cursors_delete         = multicursor.deleteCursor,
		cursors_clear          = multicursor.clearCursors,
	})
end
