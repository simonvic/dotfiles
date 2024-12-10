return function()
	local k = require("simonvic.keybindings").plugins.ts_textobjects
	---@diagnostic disable-next-line: missing-fields
	require("nvim-treesitter.configs").setup({
		textobjects = {
			swap = {
				enable = true,
				swap_next = k.swap.swap_next,
				swap_previous = k.swap.swap_previous,
			},
			lsp_interop = {
				enable = true,
				border = "rounded",
				floating_preview_opts = {},
				peek_definition_code = k.lsp_interop.peek_definition_code,
			},
			move = {
				enable = true,
				set_jumps = true, -- whether to set jumps in the jumplist
				goto_next_start = k.move.goto_next_start,
				goto_next_end = k.move.goto_next_end,
				goto_previous_start = k.move.goto_previous_start,
				goto_previous_end = k.move.goto_previous_end,
				goto_next = k.move.goto_next,
				goto_previous = k.move.goto_previous,
			},
			select = {
				enable = true,
				lookahead = true,
				include_surrounding_whitespace = false,
				keymaps = k.select.keymaps,

				-- v, V, <c-v>
				selection_modes = {
					['@parameter.outer'] = 'v',
					['@function.outer'] = 'V',
					['@class.outer'] = 'V',
				},
			},
		},
	})

	local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
	vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_next)
	vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_previous)
	vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
	vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
	vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
	vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
end
