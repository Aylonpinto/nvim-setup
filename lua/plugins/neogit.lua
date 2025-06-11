return function()
    require("neogit").setup({
        kind = "vsplit",
        integrations = {
            diffview = true,
        },
        disable_context_highlighting = true,
        disable_insert_on_commit = false,
        use_per_project_settings = false,
        signs = {
            hunk = { "", "" },
            item = { ">", "v" },
            section = { ">", "v" },
        },
        popup = {
            kind = "auto",
        },
        mappings = {
            status = {
                ["<CR>"] = "VSplitOpen",
            }
        },
    })
    
end
