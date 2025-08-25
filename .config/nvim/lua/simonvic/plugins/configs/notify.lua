return function()
	local notify = require("notify")
	notify.setup({
		stages = "slide",
		render = "compact"
	})
	vim.notify = notify
	local history = vim.cmd.Notifications

	local ok, telescope = pcall(require, "telescope")
	if ok then
		telescope.load_extension("notify")
		history = telescope.extensions.notify.notify
	end

	require("simonvic.keybindings").implement({
		notif_history = history,
		notif_dismiss = notify.dismiss,
	})
end
