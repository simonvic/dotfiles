return function()
	vim.g.undotree_SetFocusWhenToggle = true
	require("simonvic.keybindings").implement({
		undotree = vim.cmd.UndotreeToggle
	})
end
