return function()
    require("telescope").setup({
        defaults = {
            file_ignore_patterns = {
                "node_modules/",
                "__pycache__/",
                "%.pyc",
                "%.git/",
                "%.venv/",
                "__pylance__/",
                "%.DS_Store",
                "dist/",
                "build/",
            },
            mappings = {
                i = {
                    ["<CR>"] = function(prompt_bufnr)
                        local actions = require("telescope.actions")
                        actions.select_tab(prompt_bufnr)
                    end,
                },
                n = {
                    ["<CR>"] = function(prompt_bufnr)
                        local actions = require("telescope.actions")
                        actions.select_tab(prompt_bufnr)
                    end,
                },
            },
        },
    })
end