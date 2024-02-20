return function()
	local snippet = require("luasnip")
	local cmp = require("cmp")
	cmp.setup({
		snippet = {
			expand = function(args)
				snippet.lsp_expand(args.body)
			end,
		},
		window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		},
		-- formatting = {
		-- 	fields = { "kind", "abbr", "menu"}
		-- },
		sources = {
			{ name = "nvim_lsp" },
			{ name = "luasnip" },
		},
		{
			{ name = "buffer" },
			{ name = "path" },
		},
		-- TODO: cmp-git
		preselect = cmp.PreselectMode.None,
		completion = {
			autocomplete = false
		},
		mapping = {
			["<Up>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
			["<Down>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
			["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
			["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
			["<ESC>"] = cmp.mapping.abort(),
			["<C-Space>"] = cmp.mapping(function()
				if cmp.visible() then
					cmp.select_next_item()
				else
					cmp.complete()
				end
			end, { "i", "c" }),
			["<CR>"] = cmp.mapping.confirm({ select = false }),
			["<Tab>"] = cmp.mapping(function(fallback)
				if snippet.in_snippet() and snippet.jumpable(1) then
					snippet.jump(1)
				else
					fallback()
				end
			end, { "i", "s", }),
			["<S-Tab>"] = cmp.mapping(function(fallback)
				if snippet.in_snippet() and snippet.jumpable(-1) then
					snippet.jump(-1)
				else
					fallback()
				end
			end, { "i", "s" }),
		},
	})
	local cmp_autopairs = require("nvim-autopairs.completion.cmp")
	cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end
