return function()
	require("nvim_comment").setup({
		marker_padding = true,
		comment_empty = true,
		comment_empty_trim_whitespace = true,
		create_mappings = false,
		hook = nil
	})
end
