return function()
	local context = require("treesitter-context")
	context.setup({
		enable = false,
		separator = "-",
	})
	require("simonvic.keybindings").implement({
		toggle_context = context.toggle
	})
end
