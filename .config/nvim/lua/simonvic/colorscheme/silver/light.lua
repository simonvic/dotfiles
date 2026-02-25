return require("simonvic.colorscheme.silver"):build({
	palette = {

		accent__4         = "#EF9F9B",
		accent__3         = "#EF9F9B",
		accent__2         = "#EF9F9B",
		accent__1         = "#EF9F9B",
		accent            = "#F0544C",
		accent_1          = "#4C302F",
		accent_2          = "#4C302F",
		accent_3          = "#3F2727",
		accent_4          = "#3F2727",

		text__4           = "#EEEEEE",
		text__3           = "#BBBBBB",
		text__2           = "#999999",
		text__1           = "#777777",
		text              = "#444444",
		text_1            = "#333333",
		text_2            = "#222222",
		text_3            = "#111111",
		text_4            = "#000000",

		guide             = "#EEEEEE",
		code_bg           = "#E7E7E7",
		url               = "#333333",

		disabled          = "#666666",
		constant          = "#000000",
		member            = "#0A0A0A",
		func              = "#222222",
		special           = "#0A0A0A",
		metakeyword       = "#000000",
		keyword           = "#000000",
		keyword_1         = "#000000",
		literal_string__4 = "#DDDDDD",
		literal_string    = "#333333",
		literal_bool      = "#333333",
		literal_number    = "#333333",

		added__3          = "#CADBD3",
		added__2          = "#9DD0B5",
		added__1          = "#80BC9D",
		added             = "#3A8C62",
		changed__3        = "#C9C4A5",
		changed__2        = "#D4CD93",
		changed__1        = "#CFC57A",
		changed           = "#D3954A",
		deleted__3        = "#DABFBF",
		deleted__2        = "#D59797",
		deleted__1        = "#D38989",
		deleted           = "#BA484C",

		error             = "#E8312E",
		warn              = "#E87B2E",
		note              = "#D8E44C",
		info              = "#A1C7CE",
		hint              = "#8C9293",

	},
	groups = function(p)
		return {
			String  = { bg = p.text__4 },
			Keyword = { bold = true },
		}
	end
})
