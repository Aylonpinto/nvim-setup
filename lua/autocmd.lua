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

-- Format on save (Jordi's style)
vim.api.nvim_create_autocmd("BufWritePost", {
    group = vim.api.nvim_create_augroup("RuffFormatOnSave", { clear = true }),
    pattern = "*.py",
    callback = function()
        vim.fn.system({"ruff", "format", vim.fn.expand("%:p")})
        vim.fn.system({"ruff", "--fix", vim.fn.expand("%:p")})
        vim.cmd("checktime")
    end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
    group = vim.api.nvim_create_augroup("PrettierFormatTS", { clear = true }),
    pattern = {"*.js", "*.jsx", "*.ts", "*.tsx", "*.json"},
    callback = function()
        local file_path = vim.fn.expand("%:p")
        local cmd = "cd " .. vim.fn.expand("%:p:h") .. " && npx prettier --write " .. file_path
        vim.fn.jobstart(cmd, {
            on_exit = function(_, code)
                if code == 0 then
                    vim.cmd("checktime")
                end
            end,
        })
    end,
})

-- Enhanced LSP rename with inc-rename
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
        vim.keymap.set("n", "<leader>rn", ":IncRename ", { buffer = event.buf, desc = "Incremental rename" })
    end,
})