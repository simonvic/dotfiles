return function()
	require("colortils").setup()
	require("simonvic.keybindings").implement({
		color_picker = function() vim.cmd("Colortils picker") end
	})
end
