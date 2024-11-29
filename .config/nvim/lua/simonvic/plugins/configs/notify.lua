return function()
	local notify = require("notify")
	notify.setup({
		stages = "slide",
		render = "compact"
	})
	vim.notify = notify
	local ok, telescope = pcall(require, "telescope")
	if ok then telescope.load_extension("notify") end
end
