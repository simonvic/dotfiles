return function()
	require("nvim-treesitter-textobjects").setup({
		move = {
			set_jumps = true,
		},
		select = {
			lookahead = true,
			include_surrounding_whitespace = false,
			selection_modes = {
				-- v, V, <c-v>
				["@parameter.outer"] = "v",
				["@function.outer"] = "V",
				["@class.outer"] = "V",
			},
		},
	})

	local keybindings = require("simonvic.keybindings")
	local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")
	local nxo_ = keybindings.modes.nxo_
	local function make_repeatable_func(fn)
		return function()
			local _, keys = pcall(fn)
			if keys then
				local cmd = ('normal! %d%s'):format(vim.v.count1, vim.keycode(keys))
				vim.cmd(cmd)
			end
		end
	end
	keybindings.set({
		-- Override vim builtins
		-- { nxo_, ",", ts_repeat_move.repeat_last_move_next, },
		-- { nxo_, ";", ts_repeat_move.repeat_last_move_previous, },
		-- workaround for https://github.com/nvim-treesitter/nvim-treesitter-textobjects/issues/775
		{ nxo_, ",", make_repeatable_func(ts_repeat_move.repeat_last_move_next) },
		{ nxo_, ";", make_repeatable_func(ts_repeat_move.repeat_last_move_previous) },
		{ nxo_, "f", ts_repeat_move.builtin_f_expr,                                 { expr = true } },
		{ nxo_, "F", ts_repeat_move.builtin_F_expr,                                 { expr = true } },
		{ nxo_, "t", ts_repeat_move.builtin_t_expr,                                 { expr = true } },
		{ nxo_, "T", ts_repeat_move.builtin_T_expr,                                 { expr = true } },
	})
	local swap = require("nvim-treesitter-textobjects.swap")
	local move = require("nvim-treesitter-textobjects.move")
	local select = require("nvim-treesitter-textobjects.select")
	keybindings.implement({
		-- pcall so we fail silently if a parser can't be created
		move_argument_next     = function() pcall(swap.swap_next, "@parameter.inner") end,
		move_argument_prev     = function() pcall(swap.swap_previous, "@parameter.inner") end,
		move_function_next     = function() pcall(swap.swap_next, "@function.outer") end,
		move_function_prev     = function() pcall(swap.swap_previous, "@function.outer") end,
		move_class_next        = function() pcall(swap.swap_next, "@class.outer") end,
		move_class_prev        = function() pcall(swap.swap_previous, "@class.outer") end,

		goto_next_function     = function() pcall(move.goto_next_start, "@function.outer", "textobjects") end,
		goto_next_argument     = function() pcall(move.goto_next_start, "@parameter.inner", "textobjects") end,
		goto_next_class        = function() pcall(move.goto_next_start, "@class.outer", "textobjects") end,
		goto_next_comment      = function() pcall(move.goto_next_start, "@comment.outer", "textobjects") end,
		goto_prev_function     = function() pcall(move.goto_previous_start, "@function.outer", "textobjects") end,
		goto_prev_argument     = function() pcall(move.goto_previous_start, "@parameter.inner", "textobjects") end,
		goto_prev_class        = function() pcall(move.goto_previous_start, "@class.outer", "textobjects") end,
		goto_prev_comment      = function() pcall(move.goto_previous_start, "@comment.outer", "textobjects") end,

		select_around_function = function() pcall(select.select_textobject, "@function.outer", "textobjects") end,
		select_inside_function = function() pcall(select.select_textobject, "@function.inner", "textobjects") end,
		select_around_argument = function() pcall(select.select_textobject, "@parameter.outer", "textobjects") end,
		select_inside_argument = function() pcall(select.select_textobject, "@parameter.inner", "textobjects") end,
		select_around_class    = function() pcall(select.select_textobject, "@class.outer", "textobjects") end,
		select_inside_class    = function() pcall(select.select_textobject, "@class.inner", "textobjects") end,
		select_around_comment  = function() pcall(select.select_textobject, "@comment.outer", "textobjects") end,
		select_inside_comment  = function() pcall(select.select_textobject, "@comment.inner", "textobjects") end,
	})
end
