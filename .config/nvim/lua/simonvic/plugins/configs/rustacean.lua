return function()
	vim.lsp.config("rust-analyzer", {
		on_attach = function(client, buffer)
			local keybindings = require("simonvic.keybindings")
			keybindings.set(keybindings.plugins.rustacean)
		end
	})
end
