return function()
	local notify = require("notify")
	notify.setup({
		stages = "slide",
		top_down = false
	})
	vim.notify = notify
	require("telescope").load_extension("notify")
end
