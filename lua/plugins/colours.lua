return function()
    require("nightfox").setup({
        options = {
            transparent = false,
            terminal_colors = false,  -- Try disabling this
            dim_inactive = false,
            styles = {
                comments = "italic",
                keywords = "bold",
                types = "bold",
                functions = "bold",
                variables = "NONE",
                constants = "bold",
                conditionals = "bold",
                loops = "bold",
            },
        },
        specs = {
            nordfox = {
                syntax = {
                    -- keyword = "#81A1C1",      -- Nord blue for keywords
                    type = "#B48EAD",         -- Nord purple for types
                    -- variable = "#D8DEE9",     -- Nord light gray for variables
                    -- string = "#A3BE8C",       -- Nord green for strings
                    -- number = "#B48EAD",       -- Nord purple for numbers
                    -- constant = "#D08770",     -- Nord orange for constants
                    -- conditional = "#5E81AC",  -- Nord dark blue for conditionals
                    -- operator = "#ECEFF4",     -- Nord white for operators
                },
            },
        },
    })
    vim.cmd("colorscheme nightfox")
end
