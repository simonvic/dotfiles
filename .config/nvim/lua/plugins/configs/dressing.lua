return function()
	require("dressing").setup({
		input = {
			winblend = 0
		},
		select = {
			winblend = 0,
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
