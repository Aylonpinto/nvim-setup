return function()
    require("nvim-tree").setup({
        view = {
            adaptive_size = true,
            side = "left",
        },
        renderer = {
            indent_markers = {
                enable = true,
            },
        },
    })
end