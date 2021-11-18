lua <<EOF
require("bufferline").setup{
	options = {
		indicator_icon = '█',
		numbers = "both",
		right_mouse_command = nil,
		tab_size = 36,
		show_tab_indicators = true,
		separator_style = "thick",
		offsets = {{
			filetype = "NvimTree",
			text = "",
			highlight = "Directory",
			text_align = "center"
		}}
	}
}
EOF
