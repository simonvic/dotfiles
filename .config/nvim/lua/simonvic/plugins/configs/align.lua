return function()
	local keybindings = require("simonvic.keybindings")
	require("mini.align").setup({
		mappings = keybindings.plugins.align
	});
end
