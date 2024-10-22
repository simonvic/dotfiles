return function()
	local actions = require("telescope.actions")
	require("telescope").setup({
		defaults = {
			mappings = {
				i = {
					["<esc>"] = actions.close,
					["<C-h>"] = actions.select_horizontal,
					["<C-v>"] = actions.select_vertical,
					["<A-CR>"] = actions.send_selected_to_qflist,
					["<C-CR>"] = actions.send_to_qflist,
				}
			}
		},
	})
end
