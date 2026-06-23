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

-- Load coverage for Python files (Jordi's style)
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("test_coverage_show", { clear = true }),
    pattern = "python",
    callback = function()
        local python_root = vim.fn.fnamemodify(
            vim.fn.findfile("pyproject.toml", ".;") or
            vim.fn.findfile("setup.py", ".;") or
            vim.fn.getcwd(),
            ":p:h"
        )
        local coverage_path = python_root .. "/.coverage"
        local file_exists = io.open(coverage_path, "r") ~= nil

        if file_exists and vim.g.coverage_loaded == 0 then
            vim.cmd("cd " .. python_root)
            require("coverage").load(true)
            require("coverage").show()
            vim.g.coverage_loaded = 1
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
        local cmd = {"prettier", "--write", file_path}
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

-- "Ruled paper": a full-width underline under every row, so the buffer looks
-- like a grid of rows. Only applied to normal file buffers (skips nvim-tree,
-- telescope, neogit, etc.). Tweak `sp` for the line colour.
local ruled_ns = vim.api.nvim_create_namespace("ruled_paper")
local function set_ruled_hl()
    -- dotted, very subtle rule under each row (nightfox-native shade)
    vim.api.nvim_set_hl(0, "RuledPaper", { underdotted = true, sp = "#29394f" })
end
set_ruled_hl()
-- re-apply after any colorscheme load (colorschemes clear custom highlights)
vim.api.nvim_create_autocmd("ColorScheme", { callback = set_ruled_hl })
vim.api.nvim_set_decoration_provider(ruled_ns, {
    on_win = function(_, _, bufnr)
        return vim.bo[bufnr].buftype == "" -- false → skip on_line for special buffers
    end,
    on_line = function(_, _, bufnr, row)
        -- Use a range `hl_group` (not `line_hl_group`) so it renders with ephemeral
        -- extmarks — line_hl_group is broken for ephemeral (neovim#32936).
        vim.api.nvim_buf_set_extmark(bufnr, ruled_ns, row, 0, {
            end_row = row + 1,
            end_col = 0,
            hl_group = "RuledPaper",
            hl_eol = true, -- extend the underline to full window width
            ephemeral = true,
        })
    end,
})