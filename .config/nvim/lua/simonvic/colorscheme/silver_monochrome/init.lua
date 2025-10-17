return require("simonvic.colorscheme"):build({
	name = "simonvic_silver_monochrome",
	palette = {
		constant       = "#FFFFFF",
		member         = "#FAFAFA",
		["function"]   = "#CACACA",
		special        = "#FAFAFA",
		metakeyword    = "#FFFFFF",
		keyword        = "#FFFFFF",
		keyword_light  = "#FFFFFF",
		literal_string = "#EFEFEF",
		literal_bool   = "#EFEFEF",
		literal_number = "#EFEFEF",
		url            = "#EFEFEF",
	},
	groups = {
		String = { italic = true },
		Keyword = { bold = true },
	}
})


