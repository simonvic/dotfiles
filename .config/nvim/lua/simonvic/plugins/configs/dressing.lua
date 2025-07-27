return function()
	require("dressing").setup({
		input = {
			border = vim.o.winborder,
			win_options = {
				winblend = 0
			}
		},
		select = {
			get_config = function(opts)
				if opts.kind == "codeaction" then
					return {
						telescope = require("telescope.themes").get_cursor()
					}
				end
			end
		}
	})
end
