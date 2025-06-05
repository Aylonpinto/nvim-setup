-- Nvim supports the Language Server Protocol (LSP),
-- which means it acts as a client to LSP servers and includes a Lua framework
-- vim.lsp for building enhanced LSP tools.
--
-- LSP facilitates features like go-to-definition, find-references, hover,
-- completion, rename, format, refactor, etc., using semantic whole-project
-- analysis (unlike ctags).

return function()
	local lsp_zero = require("lsp-zero")
	lsp_zero.preset("recommended")
	lsp_zero.setup()


	lsp_zero.set_sign_icons({
		error = "E",
		warn = "W",
		hint = "H",
		info = "I",
	})

	vim.diagnostic.config({
		virtual_text = false,
		severity_sort = true,
		float = {
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
		signs = true,
		underline = true,
		update_in_insert = false,
	})

	-- Show line diagnostics automatically in hover window
	vim.o.updatetime = 300
	vim.cmd([[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]])
end