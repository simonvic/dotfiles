return function()
	require("dressing").setup({
		input = {
			win_options = {
				winblend = 0
			}
		},
		select = {
			win_options = {
				winblend = 0,
			},
			get_config = function(opts)
				if opts.kind == 'codeaction' then
					return {
						telescope = require("telescope.themes").get_cursor()
					}
				end
			end
		}
	})
end
