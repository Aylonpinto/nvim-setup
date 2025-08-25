return function()
	-- Here is where you configure the autocompletion settings.
	local cmp = require("cmp")
	local lspkind = require("lspkind")
	
	-- Configure luasnip
	require("luasnip.loaders.from_vscode").lazy_load()

	local has_words_before = function()
		if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
			return false
		end
		local line, col = unpack(vim.api.nvim_win_get_cursor(0))
		return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
	end

	cmp.setup({
		sources = {
			{ name = "nvim_lsp" },
      { name = "path", option = { label_trailing_slash = true } }, -- Allow trailing slashes
			{ name = "luasnip" },
		},

		formatting = {
			format = lspkind.cmp_format({
				mode = "symbol_text",
				maxwidth = 50,
				ellipsis_char = "...",
				symbol_map = { Copilot = "" },
			}),
		},

		mapping = {
			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					if cmp.get_selected_entry() then
						-- If menu is open and item selected, navigate backwards
						cmp.select_prev_item()
					else
						-- If menu is open but nothing selected, select first item
						cmp.select_next_item()
					end
				else
					-- Open completion menu
					cmp.complete()
				end
			end, { "i", "s" }),
			
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() and cmp.get_selected_entry() then
					-- Only navigate if menu is open AND an item is selected
					cmp.select_next_item()
				else
					-- Always fallback to Copilot
					fallback()
				end
			end, { "i", "s" }),
			
			["<CR>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					-- If menu is open, accept selected completion
					cmp.confirm({ select = true })
				else
					fallback()
				end
			end, { "i", "s" }),
			
			["<C-]>"] = cmp.mapping.abort(),
		},
	})
end
