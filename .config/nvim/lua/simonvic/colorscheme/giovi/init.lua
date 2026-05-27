return require("simonvic.colorscheme.ruby"):build({
	name = "giovi",
	palette = {
		giovi_doc          = "#738796",
		giovi_doc_block    = "#596974",
		giovi_natural      = "#7C69BB",
		giovi_int          = "#6869BB",
		giovi_real         = "#4A69C5",
		giovi_text         = "#6A8759",
		giovi_textblock__1 = "#283422",
		giovi_textblock    = "#5A734B",
		giovi_text_exact   = "#6A8777",
		giovi_punctation   = "#F37973",
		giovi_operator     = "#F05938",
		giovi_type         = "#FAFAFA",
	},
	groups = function(p)
		return {

			["@comment.giovi"]                     = { fg = p.text__1, italic = false },
			["@comment.block.giovi"]               = { fg = p.text__2, italic = false },
			["@comment.documentation.giovi"]       = { fg = p.giovi_doc, italic = true },
			["@comment.documentation.block.giovi"] = { fg = p.giovi_doc_block, italic = true },

			["@number.natural.giovi"]              = { fg = p.giovi_natural },
			["@number.giovi"]                      = { fg = p.giovi_int },
			["@number.float.giovi"]                = { fg = p.giovi_real },
			["@string.giovi"]                      = { fg = p.giovi_text },
			["@string.textblock.giovi"]            = { bg = p.giovi_text_block__1, fg = p.giovi_text_block },
			["@string.exact.giovi"]                = { fg = p.giovi_text_exact },

			["@punctuation.giovi"]                 = { fg = p.giovi_punctation },
			["@operator.giovi"]                    = { fg = p.giovi_operator },

			["@constant.builtin.giovi"]            = { fg = p.metakeyword },
			["@variable.builtin.giovi"]            = { fg = p.keyword_1, italic = true },
			["@type.giovi"]                        = { fg = p.giovi_type, bold = true },
			["@type.builtin.giovi"]                = { fg = p.keyword, bold = true },
			["@label.giovi"]                       = { fg = p.text__2 },
			-- ["@error.giovi"]                       = { link = "DiagnosticUnderlineError" },

			["TSCurrentScope"]                     = { bg = "#333333" },

		}
	end
})
