return function()
	-- Custom pick_many and pick_one implementations
	local pick_many = function(items, prompt, label_f, opts)
		if not items or #items == 0 then
			return {}
		end

		local choices = {}
		for i, item in pairs(items) do
			table.insert(choices, label_f(item))
		end

		local co = coroutine.running()
		vim.ui.select(choices, { prompt = prompt, },
			function(choice, index)
				local qf = vim.fn.getqflist()
				local qf_text = {}
				for i, qf_entry in pairs(qf) do
					-- Remove prefix digits added by snacks
					local text, _ = string.gsub(qf_entry.text, "[0-9]+ ", "")
					table.insert(qf_text, text)
				end
				local selected_items = {}
				for i, item in pairs(items) do
					if vim.list_contains(qf_text, label_f(item)) then
						table.insert(selected_items, item)
					end
				end
				coroutine.resume(co, selected_items)
			end
		)
		return coroutine.yield()
	end

	local pick_one = function(items, prompt, label_fn)
		local co = coroutine.running();
		local choices = {}
		for i, item in pairs(items) do
			table.insert(choices, label_fn(item))
		end
		vim.ui.select(choices, { prompt = prompt },
			function(choice, index)
				if index == nil then
					coroutine.resume(co, nil) -- Just to be explicit
				else
					coroutine.resume(co, items[index])
				end
			end
		)
		return coroutine.yield()
	end

	require("jdtls.ui").pick_many = pick_many
	require("jdtls.ui").pick_one = pick_one
end
