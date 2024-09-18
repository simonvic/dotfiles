-- TODO: zK move fold up, zJ move fold down
return function()
	---@diagnostic disable-next-line: missing-fields
	require("nvim-treesitter.configs").setup({
		textobjects = {
			swap = {
				enable = true,
				swap_next = {
					["mal"] = "@parameter.inner",
					["mfl"] = "@function.outer",
					["mcl"] = "@class.outer",
				},
				swap_previous = {
					["mah"] = "@parameter.inner",
					["mfh"] = "@function.outer",
					["mch"] = "@class.outer",
				},
			},
			lsp_interop = {
				enable = true,
				border = "rounded",
				floating_preview_opts = {},
				peek_definition_code = {
					["<leader>df"] = "@function.outer",
					["<leader>dc"] = "@class.outer",
				},
			},
			move = {
				enable = true,
				set_jumps = true, -- whether to set jumps in the jumplist
				goto_next_start = {
					["]f"] = "@function.outer",
					["]a"] = "@parameter.inner",
					["]c"] = "@class.outer",
				},
				goto_next_end = {
					["]F"] = "@function.outer",
					["]A"] = "@parameter.outer",
					["]C"] = "@class.outer",
				},
				goto_previous_start = {
					["[f"] = "@function.outer",
					["[a"] = "@parameter.inner",
					["[c"] = "@class.outer",
				},
				goto_previous_end = {
					["[F"] = "@function.outer",
					["[A"] = "@parameter.outer",
					["[C"] = "@class.outer",
				},
				goto_next = {
					-- ["]i"] = "@conditional.outer",
				},
				goto_previous = {
					-- ["[i"] = "@conditional.outer",
				}
			},
			select = {
				enable = true,
				lookahead = true,
				include_surrounding_whitespace = false,
				keymaps = {
					["af"] = "@function.outer",
					["aa"] = "@parameter.outer",
					["ac"] = "@class.outer",
					["if"] = "@function.inner",
					["ia"] = "@parameter.inner",
					["ic"] = "@class.inner",
				},

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
