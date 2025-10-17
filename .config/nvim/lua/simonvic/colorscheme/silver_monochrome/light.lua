return require("simonvic.colorscheme.silver_monochrome"):build({
	palette = {
		accent_xxxdark = "#EF9F9B",
		accent_xxdark  = "#EF9F9B",
		accent_xdark   = "#EF9F9B",
		accent_dark    = "#EF9F9B",
		accent         = "#F0544C",
		accent_light   = "#4C302F",
		accent_xlight  = "#3F2727",

		constant       = "#000000",
		member         = "#0A0A0A",
		["function"]   = "#222222",
		special        = "#0A0A0A",
		metakeyword    = "#000000",
		keyword        = "#000000",
		keyword_light  = "#000000",
		literal_string = "#333333",
		literal_bool   = "#333333",
		literal_number = "#333333",

		guide          = "#999999",
		code_bg        = "#BBBBBB",
		url            = "#333333",

		text_xxxdark   = "#EEEEEE",
		text_xxdark    = "#BBBBBB",
		text_xdark     = "#999999",
		text_dark      = "#777777",
		text           = "#333333",
		text_light     = "#222222",
		text_xxlight   = "#111111",
		text_xxxlight  = "#000000",

		disabled       = "#666666",
	},
	groups = function(p)
		return {
			String                = { bg = p.text_xxxdark },
			Keyword               = { bold = true },
			["@string.textblock"] = { bg = "#DDDDDD" },
		}
	end
})
