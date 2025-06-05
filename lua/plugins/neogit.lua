return function()
    require("neogit").setup({
        kind = "vsplit",
        integrations = {
            diffview = true,
        },
        disable_context_highlighting = false,
        disable_insert_on_commit = false,
        use_per_project_settings = false,
        signs = {
            hunk = { "", "" },
            item = { ">", "v" },
            section = { ">", "v" },
        },
        popup = {
            kind = "vsplit",
        },
        mappings = {
            status = {
                ["<CR>"] = "VSplitOpen",
            }
        },
    })
    
    -- Force git to always use colors
    vim.env.GIT_CONFIG_GLOBAL = vim.env.GIT_CONFIG_GLOBAL or ""
    vim.fn.system("git config --global color.ui always")
end