return function()
	vim.g.undotree_SetFocusWhenToggle = true
	vim.g.undotree_WindowLayout = 3
	require("simonvic.keybindings").implement({
		undotree = vim.cmd.UndotreeToggle
	})
end
