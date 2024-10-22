return function()
	local notify = require("notify")
	notify.setup({
		stages = "slide",
		render = "compact"
	})
	vim.notify = notify
	require("telescope").load_extension("notify")
end
