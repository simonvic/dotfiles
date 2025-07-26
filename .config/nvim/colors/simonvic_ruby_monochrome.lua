require("simonvic.colorscheme").apply({
	config = {
		bold_constants = true,
	},
	palette = {
		constant       = "#FFFFFF",
		member         = "#FAFAFA",
		["function"]   = "#CACACA",
		special        = "#DD5B54",
		metakeyword    = "#F0544C",
		keyword        = "#DD5B54",
		keyword_light  = "#DD5B54",
		literal_string = "#F0544C",
		literal_bool   = "#F0544C",
		literal_number = "#F0544C",
		url            = "#F0544C",
	},
	groups = {
		String = { bold = true }
	}
})
vim.g.colors_name = "simonvic_ruby_monochrome"
