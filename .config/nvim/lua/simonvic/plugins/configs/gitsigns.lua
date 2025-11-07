return function()
	local glyphs = require("simonvic.glyphs")
	local gitsigns = require('gitsigns')
	gitsigns.setup({
		sign_priority = 22,
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
		vcs_change_next           = function() gitsigns.nav_hunk("next") end,
		vcs_change_prev           = function() gitsigns.nav_hunk("prev") end,
		vcs_change_preview_inline = gitsigns.preview_hunk_inline,
		vcs_change_preview        = gitsigns.preview_hunk,
		vcs_change_select         = gitsigns.select_hunk,
		vcs_blame                 = function() vim.cmd("Gitsigns blame") end,
		vcs_blame_line            = function() vim.cmd("Gitsigns blame_line") end,
		vcs_reset                 = gitsigns.reset_hunk,
		vcs_reset_buffer          = gitsigns.reset_buffer,
	})
end
