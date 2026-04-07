require("simonvic.colorscheme.ruby"):build({
	name = "giovi",
	groups = function(p)
		return {

			["@comment.giovi"]                     = { fg = p.text__1, italic = false },
			["@comment.block.giovi"]               = { fg = p.text__2, italic = false },
			["@comment.documentation.giovi"]       = { fg = "#738796", italic = true },
			["@comment.documentation.block.giovi"] = { fg = "#596974", italic = true },

			["@number.natural.giovi"]              = { fg = "#7C69BB" },
			["@number.giovi"]                      = { fg = "#6869BB" },
			["@number.float.giovi"]                = { fg = "#4A69C5" },

			["@nontext.giovi"]                     = { bg = "none" },
			["@string.giovi"]                      = { fg = "#6A8759" },
			["@string.textblock.giovi"]            = { bg = "#283422", fg = "#5A734B" },
			["@string.block.giovi"]                = { fg = "#5A734B" },
			["@string.exact.giovi"]                = { fg = "#6A8777" },
			["@string.exact.block.giovi"]          = { fg = "#566D61" },

			["@punctuation.giovi"]                 = { fg = "#F37973" },
			["@operator.giovi"]                    = { fg = "#F05938" },

			["@constant.builtin.giovi"]            = { fg = p.metakeyword },
			["@variable.builtin.giovi"]            = { fg = p.keyword_1, italic = true },
			["@type.giovi"]                        = { fg = "#FAFAFA", bold = true },
			["@type.builtin.giovi"]                = { fg = p.keyword, bold = true },
			["@label.giovi"]                       = { fg = p.text__2 },
			-- ["@error.giovi"]                       = { link = "DiagnosticUnderlineError" },

			["TSCurrentScope"]                     = { bg = "#333333" },

		}
	end
}):apply()
