return function()
	require("multicursor-nvim").setup({
		signs = false
	})
	local keybindings = require("simonvic.keybindings")
	keybindings.set(keybindings.plugins.multicursor)
end
