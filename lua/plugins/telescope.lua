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
                        actions.select_default(prompt_bufnr)  -- Replace current buffer
                    end,
                    ["<C-t>"] = function(prompt_bufnr)
                        local actions = require("telescope.actions")
                        actions.select_tab(prompt_bufnr)  -- Open in new tab
                    end,
                },
                n = {
                    ["<CR>"] = function(prompt_bufnr)
                        local actions = require("telescope.actions")
                        actions.select_default(prompt_bufnr)  -- Replace current buffer
                    end,
                    ["<C-t>"] = function(prompt_bufnr)
                        local actions = require("telescope.actions")
                        actions.select_tab(prompt_bufnr)  -- Open in new tab
                    end,
                },
            },
        },
        extensions = {
            live_grep_args = {
                auto_quoting = true,
                mappings = {
                    i = {
                        ["<C-k>"] = require("telescope-live-grep-args.actions").quote_prompt(),
                    }
                }
            },
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "smart_case",
            }
        }
    })
    
    require("telescope").load_extension("live_grep_args")
    require("telescope").load_extension("fzf")
end