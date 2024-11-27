return function()
	local glyphs = require("simonvic.glyphs")
	require('gitsigns').setup({
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
end
