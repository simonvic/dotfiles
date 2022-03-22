let g:nvim_tree_group_empty = 1
let g:nvim_tree_indent_markers = 0
let g:nvim_tree_highlight_opened_files = 0

lua <<EOF
require('nvim-tree').setup {
	hijack_cursor = true,
	view = {
		width = 32
	},
	actions = {
		open_file = {
			quit_on_open = false
		}
	}
}
EOF
