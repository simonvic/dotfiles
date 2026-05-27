return require("simonvic.colorscheme.giovi"):build({
	palette = {

		accent__4          = "#F8D7D5",
		accent__3          = "#F7CAC7",
		accent__2          = "#F1ACA9",
		accent__1          = "#EF9F9B",
		accent             = "#F0544C",
		accent_1           = "#4C302F",
		accent_2           = "#4C302F",
		accent_3           = "#3F2727",
		accent_4           = "#3F2727",

		text__4            = "#EEEEEE",
		text__3            = "#BBBBBB",
		text__2            = "#999999",
		text__1            = "#777777",
		text               = "#444444",
		text_1             = "#333333",
		text_2             = "#222222",
		text_3             = "#111111",
		text_4             = "#000000",

		guide              = "#EEEEEE",
		code_bg            = "#E7E7E7",
		url                = "#333333",

		metakeyword        = "#908b0d",

		literal_string__4  = "#D1DDD0",
		literal_bool       = "#6897ff",

		added__3           = "#CADBD3",
		added__2           = "#9DD0B5",
		added__1           = "#80BC9D",
		added              = "#3A8C62",
		changed__3         = "#C9C4A5",
		changed__2         = "#D4CD93",
		changed__1         = "#CFC57A",
		changed            = "#D3954A",
		deleted__3         = "#DABFBF",
		deleted__2         = "#D59797",
		deleted__1         = "#D38989",
		deleted            = "#BA484C",

		error              = "#E8312E",
		warn               = "#E87B2E",
		note               = "#D8E44C",
		info               = "#A1C7CE",
		hint               = "#8C9293",

		giovi_doc          = "#467091",
		giovi_doc_block    = "#5b8baf",
		giovi_natural      = "#7C69BB",
		giovi_int          = "#6869BB",
		giovi_real         = "#4A69C5",
		giovi_text         = "#6A8759",
		giovi_textblock__1 = "#283422",
		giovi_textblock    = "#5A734B",
		giovi_text_exact   = "#6A8777",
		giovi_punctation   = "#ea3d35",
		giovi_operator     = "#f45015",
		giovi_type         = "#111111",

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
