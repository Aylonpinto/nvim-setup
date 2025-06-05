return function()
    require("nightfox").setup({
        options = {
            transparent = false,
            terminal_colors = true,
            dim_inactive = false,
            styles = {
                comments = "italic",
                keywords = "NONE",
                types = "NONE",
            },
        },
    })
    vim.cmd("colorscheme terafox")
end