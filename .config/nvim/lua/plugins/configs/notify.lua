return function()
	local notify = require("notify")
	notify.setup({
		background_color = "#333333",
		stage = "fade_in_slide_out",
		top_down = false
	})
	vim.notify = notify
	require("telescope").load_extension("notify")
end
