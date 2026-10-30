return function()
	local keybindings = require("simonvic.keybindings")
	local quicker = require("quicker")
	quicker.setup({
		constrain_cursor = false,
		edit = {
			enabled = true,
			autosave = false,
		},
		keys = keybindings.plugins.quicker,
	})
	keybindings.implement({
		quickfix_list = function() quicker.toggle({ focus = true }) end,
		location_list = function() quicker.toggle({ focus = true, loclist = true }) end
	})
end
