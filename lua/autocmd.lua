--[[ autocmd.lua ]]

-- Set splitright only for Neogit buffers
vim.api.nvim_create_autocmd("FileType", {
    pattern = "NeogitStatus",
    callback = function()
        vim.opt_local.splitright = true
    end,
    group = vim.api.nvim_create_augroup("NeogitConfig", { clear = true }),
})

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("lua_highlight", { clear = true }),
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ timeout = 300 })
    end,
})

-- Prompt before closing unsaved buffers
vim.api.nvim_create_autocmd({ "BufUnload", "BufHidden" }, {
    group = vim.api.nvim_create_augroup("confirm_save", { clear = true }),
    callback = function(event)
        local buf = event.buf
        if vim.bo[buf].modified and vim.bo[buf].buftype == "" then
            local filename = vim.api.nvim_buf_get_name(buf)
            local basename = vim.fn.fnamemodify(filename, ":t")
            if basename == "" then
                basename = "[No Name]"
            end
            
            local choice = vim.fn.confirm(
                string.format('Save changes to "%s"?', basename),
                "&Yes\n&No\n&Cancel",
                1
            )
            
            if choice == 1 then
                vim.api.nvim_buf_call(buf, function()
                    vim.cmd("write")
                end)
            elseif choice == 3 then
                return true -- Cancel the operation
            end
        end
    end,
})