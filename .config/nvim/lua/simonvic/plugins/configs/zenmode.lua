return function()
	local zenmode = require("zen-mode")
	zenmode.setup()
	require("simonvic.keybindings").implement({
		zen_mode = function()
			zenmode.toggle({
				window = {
					height = 0.95,
				}
			})
		end
	})
end
