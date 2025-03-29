return function()
	local glyphs = require("simonvic.glyphs")
	local gitsigns = require('gitsigns')
	gitsigns.setup({
		preview_config = {
			border = "rounded",
		},
		signs = {
			add          = { text = glyphs.statuscolumn.vcs.addded },
			change       = { text = glyphs.statuscolumn.vcs.changed },
			delete       = { text = glyphs.statuscolumn.vcs.deleted },
			topdelete    = { text = glyphs.statuscolumn.vcs.topdeleted },
			changedelete = { text = glyphs.statuscolumn.vcs.changed_deleted },
			untracked    = { text = glyphs.statuscolumn.vcs.untracked },
		}
	})
	require("simonvic.keybindings").implement({
		-- TODO: replace with gitsigns functions
		vcs_change_next           = function() vim.cmd("Gitsigns next_hunk") end,
		vcs_change_prev           = function() vim.cmd("Gitsigns prev_hunk") end,
		vcs_change_preview_inline = gitsigns.preview_hunk_inline,
		vcs_change_preview        = gitsigns.preview_hunk,
		vcs_blame                 = function() vim.cmd("Gitsigns blame") end,
		vcs_blame_line            = function() vim.cmd("Gitsigns blame_line") end,
	})
end
