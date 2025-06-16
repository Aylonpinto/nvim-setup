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
            nightfox = {
                syntax = {
                    comment = "#6b7089",      -- Dimmed gray for comments
                },
            },
        },
    })
    vim.cmd("colorscheme nightfox")
end
